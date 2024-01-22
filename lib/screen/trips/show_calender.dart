import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalender extends StatefulWidget {
  const ShowCalender({super.key});

  @override
  State<ShowCalender> createState() => _ShowCalenderState();
}

class _ShowCalenderState extends State<ShowCalender> {
  CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;

  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  String getSelectedDateRange() {
    if (_rangeStart != null && _rangeEnd != null) {
      final startFormatted = DateFormat('dd-MMM-yyyy').format(_rangeStart!);
      final endFormatted = DateFormat('dd-MMM-yyyy').format(_rangeEnd!);
      return '$startFormatted - $endFormatted';
    } else if (_selectedDay != null) {
      return DateFormat('dd-MMM-yyyy').format(_selectedDay!);
    } else {
      return DateFormat.yMMMMd('en_US').format(DateTime.now());
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: const Text('Select Date'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 41, 199, 201),
              Color(0xFFE4EfE9),
            ], // Adjust colors to your liking
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedOpacity(
                opacity: _rangeStart != null && _rangeEnd != null ? 1.0 : 0.3,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      _rangeStart != null && _rangeEnd != null
                          ? {'start': _rangeStart, 'end': _rangeEnd}
                          : null,
                    );
                  },
                  child: const Text(
                    'Pick Date Trip',
                    style: TextStyle(
                      color:  Colors.black // Set the color when the date is picked
                      
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 224, 224),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      getSelectedDateRange(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              onDaySelected: _onDaySelected,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              onRangeSelected: _onRangeSelected,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(
                _selectedDay,
                day,
              ),
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2050, 01, 01),
              calendarFormat: _calenderFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                  todayTextStyle: TextStyle(
                      color: Color.fromARGB(255, 195, 25, 25), fontSize: 18.0),
              
                  disabledTextStyle:
                      TextStyle(color: Color.fromARGB(255, 231, 8, 52)),
                  outsideDaysVisible: false),
              onFormatChanged: (format) {
                if (_calenderFormat != format) {
                  setState(() {
                    _calenderFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
