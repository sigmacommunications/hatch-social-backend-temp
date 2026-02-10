@extends('admin.layouts.master')
@section('content')
    <!-- DataTales Example -->
    <div class="card shadow mb-4">

        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary float-left">Interests Lists</h6>
        </div>
        <div class="card-body">
            <form action="/interests" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="form-group mb-3">
                    <label for="name">Name:</label>
                    <input type="text" name="name" id="name" class="form-control" required>
                </div>
                <div class="form-group mb-3">
                    <label for="type">Select Type:</label>
                    <select name="type" id="type" class="form-control" required>
                        <option value="traders">Traders</option>
                        <option value="biz">Biz</option>
                        <option value="invest">Invest</option>
                        <option value="social">Social</option>
                    </select>
                </div>
                <div class="form-group mb-3">
                    <label for="image">Upload Image:</label>
                    <input type="file" name="image" id="image" class="form-control" required>
                </div>
                <div class="form-group mb-3">
                    <button type="submit" class="btn btn-primary">Upload</button>
                </div>
            </form>
        </div>
    </div>
@endsection
