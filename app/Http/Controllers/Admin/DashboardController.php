<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Transaction;

class DashboardController extends Controller
{
    public function payment_ledger()
    {
        $data['package'] = Transaction::where('type','package')->get();
        $data['community_add'] = Transaction::where('type','community add')->get();
        $data['community_join'] = Transaction::where('type','community join')->get();
        $data['profile_add'] = Transaction::where('type','profile add')->get();
        $data['interests'] = Transaction::with('interest')->where('type','interest')->get();
        return view('admin.payment-ledger.index', $data);
    }
}
