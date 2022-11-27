import 'package:flutter/material.dart';
import 'package:fermentation/models/project.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);
  final Databasehelper dbHelper = Databasehelper.instance;
  late List entries = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.orangeAccent,
            Colors.deepOrange,
          ],
        )),
        child: SfCalendar(
          showNavigationArrow: true,
          selectionDecoration:
              BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
          viewHeaderStyle: const ViewHeaderStyle(
              dayTextStyle: TextStyle(color: Colors.white, fontSize: 15)),
          headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(color: Colors.white, fontSize: 15)),
          todayHighlightColor: Colors.pink,
          cellBorderColor: Colors.white,
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property

          monthViewSettings: const MonthViewSettings(
            monthCellStyle: MonthCellStyle(
                textStyle: TextStyle(color: Colors.white),
                trailingDatesTextStyle: TextStyle(color: Colors.black12),
                leadingDatesTextStyle: TextStyle(color: Colors.black12)),
            appointmentDisplayCount: 2,
            showAgenda: true,
            agendaViewHeight: 100,
            agendaStyle: AgendaStyle(
                appointmentTextStyle: TextStyle(color: Colors.white),
                dateTextStyle: TextStyle(color: Colors.white),
                dayTextStyle: TextStyle(color: Colors.white),
                placeholderTextStyle: TextStyle(color: Colors.black12)),
          ),
        ));
  }

  List<Meeting> _getDataSource() {
    _queryAll();
    final List<Meeting> meetings = <Meeting>[];
    entries.forEach((entry) {
      final DateTime today = DateTime.parse(entry["end"]);
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, 9);
      meetings.add(Meeting(entry["name"], startTime, Colors.pink));
    });
    return meetings;
  }

  void _queryAll() async {
    final projectList = [];
    final allRows = await dbHelper.queryAllRows();
    entries.clear();
    allRows.forEach((row) => projectList.add(Project.fromMap(row)));
    projectList.forEach((row) => entries.add(row.toMap()));
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.background);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// Background which is equivalent to color property of [Appointment].
  Color background;
}
