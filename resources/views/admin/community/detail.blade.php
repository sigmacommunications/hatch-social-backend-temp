@extends('admin.layouts.master')
@section('title','Nest Detail')
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
            <div class="nest-main">
                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <button class="nav-link active" id="nav-owner-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-owner" type="button" role="tab" aria-controls="nav-owner"
                            aria-selected="true">Nest Owner</button>

                        <button class="nav-link" id="nav-admin-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-admin" type="button" role="tab" aria-controls="nav-admin"
                            aria-selected="false">Nest Admins</button>

                        <button class="nav-link" id="nav-moderator-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-moderator" type="button" role="tab"
                            aria-controls="nav-moderator" aria-selected="false">Nest Moderators</button>

                        <button class="nav-link" id="nav-user-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-user" type="button" role="tab" aria-controls="nav-user"
                            aria-selected="false">Nest Users</button>

                        <button class="nav-link" id="nav-cost-tab" data-bs-toggle="tab"
                            data-bs-target="#nav-cost" type="button" role="tab" aria-controls="nav-cost"
                            aria-selected="false">Membership Cost Of Nest</button>
                    </div>
                </nav>
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-owner" role="tabpanel"
                        aria-labelledby="nav-owner-tab" tabindex="0">
                        <table style="width:100%">
                            <tr>
                                <th>S.N</th>
                                <th>Full Name</th>
                                <th>Photo</th>
                                <th>Type</th>
                            </tr>
                            @if($owner)
                            @foreach($owner as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{$row->profile_info->name}}</td>
                                <td><img src="{{$row->profile_info->photo}}" width="100" alt=""></td>
                                <td>{{$row->profile_info->type}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </table>
                    </div>

                    <div class="tab-pane fade" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab"
                        tabindex="0">
                        <table style="width:100%">
                            <tr>
                                <th>S.N</th>
                                <th>Full Name</th>
                                <th>Photo</th>
                                <th>Type</th>
                            </tr>
                            @if($admin)
                            @foreach($admin as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{$row->profile_info->name}}</td>
                                <td><img src="{{$row->profile_info->photo}}" width="100" alt=""></td>
                                <td>{{$row->profile_info->type}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </table>
                    </div>

                    <div class="tab-pane fade" id="nav-moderator" role="tabpanel"
                        aria-labelledby="nav-moderator-tab" tabindex="0">
                        <table style="width:100%">
                            <tr>
                                <th>S.N</th>
                                <th>Full Name</th>
                                <th>Photo</th>
                                <th>Type</th>
                            </tr>
                            @if($moderator)
                            @foreach($moderator as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{$row->profile_info->name}}</td>
                                <td><img src="{{$row->profile_info->photo}}" width="100" alt=""></td>
                                <td>{{$row->profile_info->type}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </table>
                    </div>

                    <div class="tab-pane fade" id="nav-user" role="tabpanel" aria-labelledby="nav-user-tab"
                        tabindex="0">
                        <table style="width:100%">
                            <tr>
                                <th>S.N</th>
                                <th>Full Name</th>
                                <th>Photo</th>
                                <th>Type</th>
                            </tr>
                            @if($member)
                            @foreach($member as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{$row->profile_info->name}}</td>
                                <td><img src="{{$row->profile_info->photo}}" width="100" alt=""></td>
                                <td>{{$row->profile_info->type}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </table>
                    </div>

                    <div class="tab-pane fade" id="nav-cost" role="tabpanel" aria-labelledby="nav-cost-tab"
                        tabindex="0">
                        <table style="width:100%">
                            <tr>
                                <th>S.N</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Date</th>
                            </tr>
                            @if($payments)
                            @foreach($payments as $key => $row)
                            <tr>
                                <td>{{$key+1}}</td>
                                <td>{{$row->type}}</td>
                                <td>{{$row->stripe_price}}</td>
                                <td>{{$row->created_at}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
@endsection