<?php

namespace App\Jobs;

use Illuminate\Bus\Batchable;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;
use Examyou\RestAPI\Exceptions\ApiException;

class StockTransfersImportJob implements ShouldQueue, ShouldBeUnique
{
    use Batchable, Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     */
    private $context;
    private $file;
    private $cacheKey;
    private $userId;
    
    public function __construct($context, $file, $cacheKey, $userId)
    {
        $this->context = $context;
        $this->file = $file;
        $this->cacheKey = $cacheKey;
        $this->userId = $userId;

         
    }

    /**
     * Get the unique ID for the job.
     */    
    public function uniqueId(): string
    {
        return 'orders';
    }
    
    /**
     * Execute the job.
     */
    public function handle(): void
    {

        $storage = Storage::disk('temp');
        
        Excel::import(new \App\Imports\StockTransferImport($this->cacheKey, $this->userId), $storage->path($this->file));
    }
}
