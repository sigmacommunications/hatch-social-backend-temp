<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\BaseController;
use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends BaseController
{
    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $perPage = $perPage > 0 ? min($perPage, 100) : 15;

        $reports = Report::with(['post', 'profile'])
            ->latest()
            ->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Reports list',
            'reports' => $reports,
        ], 200);
    }
}
