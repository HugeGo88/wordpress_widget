part of wordpress_widget;

class EventDetailData extends StatefulWidget {
  final EventEntity event;
  const EventDetailData(this.event, {super.key});

  @override
  State<EventDetailData> createState() => _EventDetailDataState();
}

class _EventDetailDataState extends State<EventDetailData> {
  late FirebaseAnalytics? analytics;
  bool useAnalytics = true;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  String allDayVenue(DateTime start, DateTime end) {
    if (start.day != end.day) {
      return "${DateFormat.Md('de').format(start)} bis ${DateFormat.yMd('de').format(end)}";
    } else {
      return DateFormat.yMd('de').format(start);
    }
  }

  @override
  void initState() {
    try {
      analytics = FirebaseAnalytics.instance;
    } catch (_) {
      useAnalytics = false;
    }
    super.initState();
  }

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: widget.event.title,
      description: widget.event.description,
      location: widget.event.address,
      startDate: widget.event.startDate,
      endDate: widget.event.endDate,
      allDay: widget.event.allDay,
      iosParams: IOSParams(
        reminder: const Duration(minutes: 60),
        url: widget.event.url,
      ),
      androidParams: const AndroidParams(
        emailInvites: [],
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool venueSet = widget.event.venue == "" ? false : true;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: edgePadding, right: contentPadding),
              child: Icon(
                PlatformIcons(context).time,
                size: iconSizeBig,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: Theme.of(context).textTheme.bodyMedium,
                    widget.event.allDay
                        ? allDayVenue(
                            widget.event.startDate, widget.event.endDate)
                        : DateFormat.MMMMEEEEd('de')
                            .format(widget.event.startDate),
                  ),
                  if (!widget.event.allDay)
                    Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      "${DateFormat.Hm('de').format(widget.event.startDate)} Uhr bis ${DateFormat.Hm('de').format(widget.event.endDate)} Uhr",
                    ),
                ],
              ),
            ),
            PlatformIconButton(
              materialIcon: const Icon(Icons.edit_calendar_outlined),
              cupertinoIcon: const Icon(CupertinoIcons.calendar_badge_plus),
              onPressed: () async {
                if (useAnalytics) {
                  await analytics?.logEvent(
                    name: "button_tracked",
                    parameters: {
                      "button_name": "AddCalendar",
                    },
                  );
                }
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
            ),
          ],
        ),
        if (venueSet)
          Row(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: edgePadding, right: contentPadding),
                child: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  size: iconSizeBig,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.venue,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.event.address,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              PlatformIconButton(
                cupertinoIcon: const Icon(CupertinoIcons.map),
                materialIcon: const Icon(Icons.map_outlined),
                onPressed: () async {
                  if (useAnalytics) {
                    await analytics?.logEvent(
                      name: "button_tracked",
                      parameters: {
                        "button_name": "OpenMap",
                      },
                    );
                  }
                  MapsLauncher.launchQuery(widget.event.address);
                },
              ),
            ],
          ),
        if (widget.event.ticket != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.event.ticket?.capacity != "-1")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edgePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Anmeldung erforderlich",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.apply(color: Theme.of(context).primaryColor),
                      ),
                      if (DateTime.now()
                          .isBefore(widget.event.ticket!.startDate))
                        Text(
                          "Buchungsfreischaltung ab ${DateFormat.yMd('DE').add_jm().format(widget.event.ticket!.startDate)} Uhr",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(color: Theme.of(context).primaryColor),
                        ),
                    ],
                  ),
                ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: edgePadding, right: contentPadding),
                    child: Icon(
                      CupertinoIcons.ticket,
                      size: iconSizeBig,
                    ),
                  ),
                  if (widget.event.ticket!.stock != "-1")
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "${widget.event.ticket!.stock} Plätze übrig",
                      ),
                    )
                  else
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "Plätze übrig",
                      ),
                    ),
                  if (DateTime.now().isAfter(widget.event.ticket!.startDate))
                    PlatformIconButton(
                      icon: Icon(
                        PlatformIcons(context).add,
                      ),
                      onPressed: () async {
                        if (useAnalytics) {
                          await analytics?.logEvent(
                            name: "button_tracked",
                            parameters: {
                              "button_name": "AddTicket",
                            },
                          );
                        }
                        _launchInBrowser(
                          Uri.parse("${widget.event.url}/#rsvp-now"),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        Container(
          height: 3.0,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
