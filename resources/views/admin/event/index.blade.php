@extends('admin.layouts.master')
@section('title','Evemt')
@section('content')
            <div class="center-main">
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
                    <div class="main-content">
                        <div class="event-calendar">
                            <div id="calendar"></div>
                        </div>

                        <div class="event-review">
                            <h4 class="e1a">Events Review</h4>
                            <div class="event-review-inner">
                                <div class="event-review-details">
                                    <h4 class="e1b">05</h4>
                                    <h4 class="e1c">Events Review</h4>
                                </div>
                                <p class="e1e">Curabitur dapibus nibh et est dictum, et volutpat lorem pellentesque.
                                    Suspendisse accumsan dolor leo, eget pharetra erat viverra ac. Vestibulum mi velit,
                                    cursus ac bibendum ut, gravida id nunc. Quisque pulvinar ante in lacus egestas
                                    sagittis.
                                    Donec maximus mauris sit amet mattis convallis. Nam lorem arcu, fringilla a orci
                                    semper,
                                    imperdiet aliquet lorem. Aliquam eu interdum ante. Curabitur vel vulputate nunc.
                                    Vivamus
                                    porttitor mollis libero vitae imperdiet. Integer sed viverra arcu, ut pulvinar nunc.
                                    Sed
                                    id varius ante, vitae malesuada nulla. Curabitur condimentum mi a turpis semper
                                    pharetra. Nunc sapien odio, convallis sit amet malesuada nec, tristique sed turpis.
                                </p>
                                <a href="#" class="e1-btn">More Info</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="event-main">
                    <h4 class="e1a">Events</h4>
                    @if($events)
                    @foreach($events as $event)
                    <div class="event-div">
                        <img src="{{$event['image']}}" class="event-image" />
                        <div class="event-details">
                            <h4 class="events1b">{{$event['title']}}</h4>
                            <p class="events1c">{{$event['description']}}</p>
                            <p class="event-date"> {{ \Carbon\Carbon::parse($event['date'])->format('F / d / Y') }}</p>
                        </div>
                    </div>
                    @endforeach
                    <div class="text-danger">
                        <p>Event Not Found!!</p>
                    </div>
                    @endif
                </div>
            </div>

            <div>
    <p class="copyright-admin">Copyright © 2024 Michael Durham All Rights Reserved.</p>
</div>
</div>
</section>

@push('scripts')
<script>
    //Event
    $(document).ready(function () {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next',
                center: 'title',
                right: 'month,basicWeek,basicDay'
            },
            defaultDate: new Date(),
            navLinks: true,
            editable: true,
            eventLimit: true,
            events: @json($events),
            eventRender: function (event, element) {
                if (event.url) {
                    element.attr('target', '_blank');
                }
            }
        });
        });
</script>
@endpush
@endsection