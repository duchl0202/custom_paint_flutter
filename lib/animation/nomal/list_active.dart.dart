
import 'dart:math';

import 'package:flutter/material.dart';

class SchedulePickerScreen extends StatefulWidget {
  @override
  _SchedulePickerScreenState createState() => _SchedulePickerScreenState();
}

class _SchedulePickerScreenState extends State<SchedulePickerScreen> {
  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  final Map<String, bool> activeDays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
  };

  final Map<String, GlobalKey<AnimatedListState>> listKeys = {
    for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'])
      day: GlobalKey<AnimatedListState>(),
  };

  final Map<String, List<Map<String, String>>> timeSlots = {
    for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'])
      day: [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          final day = weekdays[index];
          return _buildDaySchedule(day);
        },
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: activeDays[day]! ? Colors.transparent : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: activeDays[day]! ? Colors.blue : Colors.transparent,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: activeDays[day]!,
                onChanged: (value) {
                  setState(() {
                    activeDays[day] = value;
                  });
                },
              ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            height: activeDays[day]!
                ? max((timeSlots[day]!.length * 60 + 60).toDouble(), 1)
                : 1,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: activeDays[day]! ? 1.0 : 0.0,
              child: Column(
                children: [
                  Flexible(
                    child: AnimatedList(
                      key: listKeys[day],
                      initialItemCount: timeSlots[day]!.length,
                      itemBuilder: (context, index, animation) {
                        final slot = timeSlots[day]![index];
                        return _buildListItem(day, slot, index, animation);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final newSlot = _generateRandomTimeSlot();
                            timeSlots[day]!.add(newSlot);
                            listKeys[day]!.currentState!.insertItem(
                                timeSlots[day]!.length - 1,
                                duration: const Duration(milliseconds: 500));
                            setState(() {});
                          },
                          icon: const Icon(Icons.add),
                          label: Text(
                            'Add More',
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(String day, Map<String, String> slot, int index,
      Animation<double> animation) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutBack,
    );

    return SizeTransition(
      sizeFactor: curvedAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'From: ${slot['from']}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'To: ${slot['to']}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                _removeTimeSlot(day, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _removeTimeSlot(String day, int index) {
    final removedSlot = timeSlots[day]![index];
    timeSlots[day]!.removeAt(index);
    setState(() {});
    listKeys[day]!.currentState!.removeItem(
          index,
          (context, animation) =>
              _buildListItem(day, removedSlot, index, animation),
          duration: const Duration(milliseconds: 500),
        );
  }

  Map<String, String> _generateRandomTimeSlot() {
    final random = Random();
    int startHour = random.nextInt(12);
    int startMinute = random.nextInt(60);
    int duration = random.nextInt(3) + 1;

    String formatTime(int hour, int minute) {
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour > 12
          ? hour - 12
          : hour == 0
              ? 12
              : hour;
      String minuteStr = minute.toString().padLeft(2, '0');
      return '$hour:$minuteStr $period';
    }

    String fromTime = formatTime(startHour, startMinute);
    String toTime = formatTime((startHour + duration) % 24, startMinute);

    return {'from': fromTime, 'to': toTime};
  }
}
