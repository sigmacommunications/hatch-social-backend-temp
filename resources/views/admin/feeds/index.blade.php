@extends('admin.layouts.master')
@section('title','Feeds')
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
                    <div class="feeds-main">
                        @foreach($feeds as $row)
                        <div class="feed-inner">
                            <img src="{{$row->image}}" class="feed-img" />
                            <div class="author-div">
                                <img src="{{$row->image}}" />
                                <h4 class="author-name">{{$row->name}}</h4>
                            </div>
                            <p class="feed-text">{{$row->description}}</p>
                        </div>
                        @endforeach
                    </div>
                </div>
            </div>
@endsection