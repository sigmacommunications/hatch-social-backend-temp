@extends('admin.layouts.master')
@section('title','Shop')
@section('content')
<div class="member">
    <div class="inner-div">
        <div class="search-box">
            <div class="input-group">
                <div class="input-group-prepend">
                    <button id="button-addon2" type="submit" class="btn btn-link text-warning"><i
                            class="fa fa-search"></i></button>
                </div>
                <input type="search" placeholder="Search..." aria-describedby="button-addon2"
                    class="form-control border-0 bg-light">
            </div>
        </div>
    </div>
    <div class="membership-main">
        <div class="shop-main">
            <div class="total-interest">
                @if($products)
                @foreach($products as $row)
                <div class="single-interest">
                    <div class="picture-div">
                        @if($row->imagee)
                        <img src="/storage/{{$row->imagee->name}}" width="100" />
                        @else
                        No Image Found!
                        @endif
                    </div>
                    <div class="meta">
                        <h4 class="published-date">{{$row->created_at}}</h4>
                        <!-- <div class="msg">
                            <i class="fa-solid fa-message"></i>
                            280
                        </div>
                        <div class="msg">
                            <i class="fa-solid fa-heart"></i>
                            89
                        </div> -->
                    </div>
                    <p class="interest-description">{{ Str::of($row->title)->limit(20);}}</p>
                </div>
                @endforeach
                @endif
            </div>
        </div>
    </div>
</div>
@endsection