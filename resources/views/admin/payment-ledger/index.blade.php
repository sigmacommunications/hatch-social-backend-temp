@extends('admin.layouts.master')
@section('title','Payment Ledger')
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
                                    aria-selected="true">Hatch Social Membership Ledger</button>

                                <button class="nav-link" id="nav-admin-tab" data-bs-toggle="tab"
                                    data-bs-target="#nav-admin" type="button" role="tab" aria-controls="nav-admin"
                                    aria-selected="false">Nest Payments</button>

                                <button class="nav-link" id="nav-moderator-tab" data-bs-toggle="tab"
                                    data-bs-target="#nav-moderator" type="button" role="tab"
                                    aria-controls="nav-moderator" aria-selected="false">Interest Payments</button>

                                <button class="nav-link" id="nav-user-tab" data-bs-toggle="tab"
                                    data-bs-target="#nav-user" type="button" role="tab" aria-controls="nav-user"
                                    aria-selected="false">Nest Membership Payments</button>
                            </div>
                        </nav>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-owner" role="tabpanel"
                                aria-labelledby="nav-owner-tab" tabindex="0">
                                <table style="width:100%">
                                    <tr>
                                        <th>S.N</th>
                                        <th>Full Name</th>
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Contact Number</th>
                                        <th>Pay Amount</th>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>02</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>03</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>04</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="tab-pane fade" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab"
                                tabindex="0">
                                <table style="width:100%">
                                    <tr>
                                        <th>S.N</th>
                                        <th>Full Name</th>
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Contact Number</th>
                                        <th>Pay Amount</th>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>02</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>03</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>04</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="tab-pane fade" id="nav-moderator" role="tabpanel"
                                aria-labelledby="nav-moderator-tab" tabindex="0">
                                <table style="width:100%">
                                    <tr>
                                        <th>S.N</th>
                                        <th>Full Name</th>
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Contact Number</th>
                                        <th>Pay Amount</th>
                                    </tr>
                                    @if($interests)
                                    @foreach($interests as $key => $row)
                                    <tr>
                                        <td>{{$row+1}}</td>
                                        <td>{{$row->type}}</td>
                                        <td>{{$row->name}}</td>
                                        <td>{{$row->name}}</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
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
                                        <th>Address</th>
                                        <th>Email</th>
                                        <th>Contact Number</th>
                                        <th>Pay Amount</th>
                                    </tr>
                                    <tr>
                                        <td>01</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>02</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>03</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                    <tr>
                                        <td>04</td>
                                        <td>Arsenio Goff</td>
                                        <td>Lorem ipsum dolor sit amet</td>
                                        <td>sdadasdsd@gmail.com</td>
                                        <td>+1 4561 456 7893</td>
                                        <td><button class="pref-btn">$5</button></td>
                                    </tr>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
@endsection