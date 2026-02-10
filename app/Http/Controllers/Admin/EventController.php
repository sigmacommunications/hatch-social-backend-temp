<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Event;
use Carbon\Carbon;
class EventController extends Controller
{
    public function index()
    {
        $today = Carbon::today();
        $events = Event::with('image')->whereDate('date', '>=', $today)->get()->map(function ($event) {
        // $events = Event::whereDate('date', '>=', $today)->get()->map(function ($event) {
            return [
                'title' => $event->title,
                'date' => $event->date,
                'time'   => $event->time,
                'description'   => $event->description,
                'image'   => $event->image->name,
            ];
        });
        return view('admin.event.index', compact('events'));
    }
}
