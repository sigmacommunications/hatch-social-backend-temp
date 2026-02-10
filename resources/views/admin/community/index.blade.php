@extends('admin.layouts.master')
@section('title','Nest')
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
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">Communities</h6>
                            <a href="{{ route('nests.create') }}" class="btn btn-sm btn-primary">
                                <i class="fa-solid fa-circle-plus me-1"></i> Add Community
                            </a>
                        </div>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-owner" role="tabpanel"
                                aria-labelledby="nav-owner-tab" tabindex="0">
                                <table style="width:100%">
                                    <tr>
                                        <th>S.N</th>
                                        <th>Full Name</th>
                                        <th>Privacy</th>
                                        <th>Joining Cost</th>
                                        <th>Image</th>
                                        <th>Members</th>
                                        <th>Action</th>
                                    </tr>
                                    @if($communities)
                                    @foreach($communities as $key => $community)
                                    <tr>
                                        <td>{{$key+1}}</td>
                                        <td>{{$community->title}}</td>
                                        <td>{{$community->privacy}}</td>
                                        <td>{{($community->joining_cost) ? $community->joining_cost : 'N/A'}}</td>
                                        <td><img src="{{$community->image}}" width="100" alt=""></td>
                                        <td><i class="fa fa-users"></i> {{$community->total_members->count()}}</td>
                                        <td class="d-flex flex-wrap gap-1">
                                            <a href="{{ route('nests.show', $community) }}" class="btn btn-outline-secondary btn-sm">Detail</a>
                                            <a href="{{ route('nests.edit', $community) }}" class="btn btn-outline-primary btn-sm">Edit</a>
                                            <form action="{{ route('nests.destroy', $community) }}" method="POST" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-outline-danger btn-sm"
                                                    onclick="return confirm('Delete {{ $community->title }}?')">Delete</button>
                                            </form>
                                        </td>
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
