import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

// enum Calendar { day, week, month, year }
enum Calendar { month, year }

class _OverviewPageState extends State<OverviewPage> {
  Calendar calendarView = Calendar.month;
  DateTime selectedMonth = DateTime.now(); // Store selected month
  int selectedYear = DateTime.now().year; // Store selected year

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        scrolledUnderElevation: 0,
        title: Text(
          'Tổng quan',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Column(
            children: [
              SegmentedButton<Calendar>(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
                    side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.teal))),
                segments: const <ButtonSegment<Calendar>>[
                  // ButtonSegment<Calendar>(
                  //     value: Calendar.day,
                  //     label: Text('Day'),
                  //     icon: Icon(Icons.calendar_view_day)),
                  // ButtonSegment<Calendar>(
                  //     value: Calendar.week,
                  //     label: Text('Week'),
                  //     icon: Icon(Icons.calendar_view_week)),
                  ButtonSegment<Calendar>(
                      value: Calendar.month,
                      label: Text('Theo tháng'),
                      icon: Icon(
                        Icons.calendar_view_month,
                        color: Colors.teal,
                      )),
                  ButtonSegment<Calendar>(
                      value: Calendar.year,
                      label: Text('Theo năm'),
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.teal,
                      )),
                ],
                selected: <Calendar>{calendarView},
                onSelectionChanged: (Set<Calendar> newSelection) {
                  setState(() {
                    // By default there is only a single segment that can be
                    // selected at one time, so its value is always the first
                    // item in the selected set.
                    calendarView = newSelection.first;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8))),
                          onPressed: () async {
                            // final DateTime? picked = await showDatePicker(
                            //   context: context,
                            //   initialDate: selectedMonth,

                            //   firstDate: DateTime(
                            //       2000), // Adjust start limit as needed
                            //   lastDate:
                            //       DateTime(2100), // Adjust end limit as needed
                            // );

                            // if (picked != null) {
                            //   setState(() {
                            //     selectedMonth = picked;
                            //   });
                            //   // TODO: Use the 'selectedMonth' to fetch and display weather data
                            // }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(calendarView == Calendar.month
                                  ? 'Tháng ${selectedMonth.month}/${selectedMonth.year}'
                                  : selectedYear.toString()),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon((Icons.calendar_month))
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      // padding: const EdgeInsets.all(16),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.blue),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Người dùng ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.group_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '123,456',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.yellowAccent.shade700),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Từ vựng',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.menu_book,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '123',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Đóng góp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.extension,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '12',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.blue),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Mẫu câu giao tiếp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.record_voice_over_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '14',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.yellow.shade800),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Động từ bất quy tắt',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.article,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '24',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.teal.shade400),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bộ từ vựng',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.book,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '244',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                )
                              ]),
                        )
                      ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widget for YearPicker
class YearPicker extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onChanged; // Add this line

  const YearPicker({
    Key? key,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged, // Include in the constructor
  }) : super(key: key);

  @override
  _YearPickerState createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.selectedDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Chọn năm"),
      content: SizedBox(
        width: double.maxFinite,
        child: YearPicker(
          selectedDate: DateTime(_selectedYear),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          onChanged: (year) {
            _selectedYear = year.year;
            Navigator.of(context).pop(_selectedYear);
          },
        ),
      ),
    );
  }
}
