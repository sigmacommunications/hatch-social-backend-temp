<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController as BaseController;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Package;

class PackageController extends BaseController
{
    public function package_list()
    {
        try
        {
            $package = Package::get();
            return response()->json(['success'=>true,'message'=>'Package List','package_list'=>$package]);
        }
        catch(\Eception $e)
        {
            return $this->sendError($e->getMessage());
        }
    }
}
