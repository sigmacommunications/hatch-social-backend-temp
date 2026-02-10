<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::get();
        // return $products[2]->imagee;
        return view('admin.product.index', compact('products'));
    }
}
