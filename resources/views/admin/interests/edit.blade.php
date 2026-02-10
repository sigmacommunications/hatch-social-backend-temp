@extends('admin.layouts.master')
@section('content')
    <!-- DataTales Example -->
    <div class="card shadow mb-4">

        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary float-left">Interests Lists</h6>
        </div>
        <div class="card-body">
            <form action="/interests/{{ $interest->id }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('put')
                <div class="form-group mb-3">
                    <label for="name">Name:</label>
                    <input type="text" name="name" value="{{ $interest->name }}" id="name" class="form-control"
                        required>
                </div>
                <div class="form-group mb-3">
                    <label for="type">Select Type:</label>
                    <select name="type" id="type" class="form-control" required>
                        <option {{ $interest->type == 'traders' ? 'selected' : null }} value="traders">Traders</option>
                        <option {{ $interest->type == 'biz' ? 'selected' : null }} value="biz">Biz</option>
                        <option {{ $interest->type == 'invest' ? 'selected' : null }} value="invest">Invest</option>
                        <option {{ $interest->type == 'social' ? 'selected' : null }} value="social">Social</option>
                    </select>
                </div>
                <div class="form-group mb-3">
                    <label for="image">Upload New Image:</label>
                    <input type="file" name="image" id="image" class="form-control">
                </div>
                @if ($interest->image)
                    <div class="mb-3">
                        <label>Current Image:</label><br>
                        <img src="{{ asset('storage/' . $interest->image) }}" alt="Interest Image"
                            style="width:120px; height:auto; border-radius:8px;">
                    </div>
                @endif
                <div class="form-group mb-3">
                    <button type="submit" class="btn btn-primary">Upload</button>
                </div>
            </form>
        </div>
    </div>
@endsection
