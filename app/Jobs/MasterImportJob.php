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

class MasterImportJob implements ShouldQueue, ShouldBeUnique
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
        return $this->context;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {

        $storage = Storage::disk('temp');
        
        if ($this->context == "brands") {
            Excel::import(new \App\Imports\BrandImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "categories") {
            Excel::import(new \App\Imports\CategoryImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } 
        else if ($this->context == "parts") {
            Excel::import(new \App\Imports\PartImport($this->cacheKey, $this->userId), $storage->path($this->file));
        }
        else if ($this->context == "colors") {
            Excel::import(new \App\Imports\ColorImport($this->cacheKey, $this->userId), $storage->path($this->file));
        }  else if ($this->context == "groups") {
            Excel::import(new \App\Imports\GroupImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "customers") {
            Excel::import(new \App\Imports\CustomerImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "suppliers") {
            Excel::import(new \App\Imports\SupplierImport($this->cacheKey, $this->userId), $storage->path($this->file));
        }else if ($this->context == "stores") {
            Excel::import(new \App\Imports\StoreImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "floors") {
            Excel::import(new \App\Imports\FloorImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "shelf-groups") {
            Excel::import(new \App\Imports\ShelfGroupImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "shelf-numbers") {
            Excel::import(new \App\Imports\ShelfNumberImport($this->cacheKey, $this->userId), $storage->path($this->file));
        } else if ($this->context == "rows") {
            Excel::import(new \App\Imports\RowImport($this->cacheKey, $this->userId), $storage->path($this->file));
        }
    }
}
