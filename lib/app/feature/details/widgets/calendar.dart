import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../services/firestore_service.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic>? _selectedEntry;

  final Color _pastelPurple = const Color(0xFFBA99EA);
  final Color _lightGrey = const Color(0xFFE5DFE6);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Card(
        color: _lightGrey,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.calendar_month_outlined,
                      color: Colors.black, size: 28),
                  SizedBox(width: 12),
                  Text(
                    "Calendar",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,

                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },

                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _selectedEntry = null;
                      });

                      final entry = await _firestoreService
                          .getHairEntryByDate(selectedDay);

                      setState(() {
                        _selectedEntry = entry;
                      });

                      if (entry != null) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Hair Entry"),
                            content: Text(
                              "Hairstyle: ${entry['hairstyle']}\n"
                                  "Rating: ${entry['rating']}/5\n"
                                  "Products: ${entry['products'] ?? '-'}",
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            content: Text("No entry for this day."),
                          ),
                        );
                      }
                    }
                  },

                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },

                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },

                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: _pastelPurple,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: _pastelPurple.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}