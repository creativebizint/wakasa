<?php

namespace Tests\Feature\Api;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\User;
use App\Models\Warehouse;
use App\Models\Category;
use App\Models\Unit;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * OrderItemController Test Suite
 *
 * Tests the Penerimaan Barang (Goods Receipt) functionality
 * Reference: FSD-PenerimaanBarang.md
 */
class OrderItemControllerTest extends TestCase
{
    use RefreshDatabase;

    private $user;
    private $warehouse;
    private $product;
    private $order;

    protected function setUp(): void
    {
        parent::setUp();

        $this->user = User::factory()->create();
        $this->warehouse = Warehouse::factory()->create();
        $this->product = Product::factory()->create();
        $this->order = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'purchases',
        ]);
    }

    /**
     * Test: User can view list of order items
     * AC1: Order Items Listing
     */
    public function test_can_list_order_items()
    {
        OrderItem::factory()->count(5)->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    '*' => [
                        'xid',
                        'x_order_id',
                        'x_product_id',
                        'quantity',
                        'unit_price',
                        'subtotal',
                    ]
                ]
            ]);
    }

    /**
     * Test: Items are filtered by warehouse
     * AC3: Multi-Warehouse Support
     */
    public function test_filters_items_by_warehouse()
    {
        $warehouse2 = Warehouse::factory()->create();
        $order2 = Order::factory()->create([
            'warehouse_id' => $warehouse2->id,
            'order_type' => 'purchases',
        ]);

        OrderItem::factory()->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
        ]);

        OrderItem::factory()->create([
            'order_id' => $order2->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?warehouse_id=' . $this->warehouse->xid);

        $response->assertStatus(200);
        $data = $response->json('data');

        $this->assertCount(1, $data);
    }

    /**
     * Test: Items from both warehouse_id and from_warehouse_id are included
     * AC3: Multi-Warehouse Support
     */
    public function test_includes_items_from_source_and_destination_warehouses()
    {
        $warehouse2 = Warehouse::factory()->create();

        $transferOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'from_warehouse_id' => $warehouse2->id,
            'order_type' => 'stock-transfers',
        ]);

        OrderItem::factory()->create([
            'order_id' => $transferOrder->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?warehouse_id=' . $this->warehouse->xid);

        $response->assertStatus(200);
        $this->assertNotEmpty($response->json('data'));
    }

    /**
     * Test: User can filter by date range
     * AC4: Date Range Filtering
     */
    public function test_filters_items_by_date_range()
    {
        $startDate = now()->subDays(7)->format('Y-m-d');
        $endDate = now()->format('Y-m-d');

        $oldOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'purchases',
            'order_date' => now()->subDays(30),
        ]);

        OrderItem::factory()->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
        ]);

        OrderItem::factory()->create([
            'order_id' => $oldOrder->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson("/api/v1/order-items?dates={$startDate},{$endDate}");

        $response->assertStatus(200);
        $data = $response->json('data');

        $this->assertCount(1, $data);
    }

    /**
     * Test: User can generate sales summary by product
     * AC2: Product Sales Summary
     */
    public function test_generates_product_sales_summary()
    {
        $salesOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'sales',
        ]);

        OrderItem::factory()->count(3)->create([
            'order_id' => $salesOrder->id,
            'product_id' => $this->product->id,
            'quantity' => 10,
            'subtotal' => 500000,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?product_sales_summary=true');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    '*' => [
                        'x_product_id',
                        'name',
                        'item_code',
                        'unit_sold',
                        'total_sales_price',
                    ]
                ]
            ]);

        $data = $response->json('data.0');
        $this->assertEquals(30, $data['unit_sold']);
        $this->assertEquals(1500000, $data['total_sales_price']);
    }

    /**
     * Test: Sales summary only includes sales orders
     * AC2: Product Sales Summary
     */
    public function test_sales_summary_excludes_non_sales_orders()
    {
        $purchaseOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'purchases',
        ]);

        $salesOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'sales',
        ]);

        OrderItem::factory()->create([
            'order_id' => $purchaseOrder->id,
            'product_id' => $this->product->id,
            'quantity' => 100,
        ]);

        OrderItem::factory()->create([
            'order_id' => $salesOrder->id,
            'product_id' => $this->product->id,
            'quantity' => 10,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?product_sales_summary=true');

        $response->assertStatus(200);
        $data = $response->json('data.0');

        $this->assertEquals(10, $data['unit_sold']);
    }

    /**
     * Test: User can filter sales summary by category
     * AC2: Product Sales Summary
     */
    public function test_filters_sales_summary_by_category()
    {
        $category1 = Category::factory()->create();
        $category2 = Category::factory()->create();

        $product1 = Product::factory()->create(['category_id' => $category1->id]);
        $product2 = Product::factory()->create(['category_id' => $category2->id]);

        $salesOrder = Order::factory()->create([
            'warehouse_id' => $this->warehouse->id,
            'order_type' => 'sales',
        ]);

        OrderItem::factory()->create([
            'order_id' => $salesOrder->id,
            'product_id' => $product1->id,
        ]);

        OrderItem::factory()->create([
            'order_id' => $salesOrder->id,
            'product_id' => $product2->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?product_sales_summary=true&category_id=' . $category1->xid);

        $response->assertStatus(200);
        $data = $response->json('data');

        $this->assertCount(1, $data);
    }

    /**
     * Test: User can apply custom sorting
     * AC5: Custom Sorting
     */
    public function test_applies_custom_sorting()
    {
        OrderItem::factory()->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
            'quantity' => 5,
        ]);

        OrderItem::factory()->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
            'quantity' => 15,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?custom_sorter=quantity DESC');

        $response->assertStatus(200);
        $data = $response->json('data');

        $this->assertEquals(15, $data[0]['quantity']);
        $this->assertEquals(5, $data[1]['quantity']);
    }

    /**
     * Test: Results are paginated
     * AC1: Order Items Listing
     */
    public function test_results_are_paginated()
    {
        OrderItem::factory()->count(25)->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items?limit=10');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data',
                'meta' => [
                    'paging' => [
                        'total',
                        'links'
                    ]
                ]
            ]);

        $this->assertCount(10, $response->json('data'));
    }

    /**
     * Test: All IDs are properly hashed in responses
     * AC1: Order Items Listing
     */
    public function test_ids_are_hashed_in_response()
    {
        $orderItem = OrderItem::factory()->create([
            'order_id' => $this->order->id,
            'product_id' => $this->product->id,
        ]);

        $response = $this->actingAs($this->user, 'api')
            ->getJson('/api/v1/order-items');

        $response->assertStatus(200);
        $data = $response->json('data.0');

        $this->assertArrayHasKey('xid', $data);
        $this->assertArrayHasKey('x_order_id', $data);
        $this->assertArrayHasKey('x_product_id', $data);
        $this->assertArrayNotHasKey('id', $data);
        $this->assertArrayNotHasKey('order_id', $data);
        $this->assertArrayNotHasKey('product_id', $data);
    }
}
