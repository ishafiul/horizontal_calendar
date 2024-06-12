import 'package:flutter/material.dart';
import 'package:horizontal_calender/horizontal_calender.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final DateTimelineController dateController = DateTimelineController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final ValueNotifier<DateTime> selectedDate =
      ValueNotifier<DateTime>(DateTime.now());

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedDate,
                    builder:
                        (BuildContext context, DateTime value, Widget? child) {
                      return Text(
                        DateFormat('MMM yyyy').format(value),
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text('Today'),
                        onPressed: () async {
                          /*final int initialIndex =
                                  DateTime.now().difference(initialDate).inDays;

                              await controller.scrollToIndex(
                                initialIndex,
                                preferPosition: AutoScrollPosition.middle,
                                duration: const Duration(milliseconds: 100),
                              );
                              selectedDate.value = DateTime.now();
                              selectedIndex.value = initialIndex;*/
                          await dateController.animateToDate(DateTime.now());
                        },
                      ),
                      TextButton(
                        child: const Text('Selected Date'),
                        onPressed: () async {
                          /*final int initialIndex =
                                  DateTime.now().difference(initialDate).inDays;

                              await controller.scrollToIndex(
                                initialIndex,
                                preferPosition: AutoScrollPosition.middle,
                                duration: const Duration(milliseconds: 100),
                              );
                              selectedDate.value = DateTime.now();
                              selectedIndex.value = initialIndex;*/
                          dateController.animateToSelection();
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: const EdgeInsets.all(24),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SfDateRangePicker(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        showNavigationArrow: true,
                                        headerHeight: 56,
                                        headerStyle: DateRangePickerHeaderStyle(
                                          backgroundColor:
                                              Theme.of(context).cardColor,
                                        ),
                                        onSelectionChanged: (
                                          DateRangePickerSelectionChangedArgs
                                              dateRangePickerSelectionChangedArgs,
                                        ) async {
                                          Navigator.of(context).pop();
                                          await dateController.animateToDate(
                                            DateTime.parse(
                                              dateRangePickerSelectionChangedArgs
                                                  .value
                                                  .toString(),
                                            ),
                                          );
                                        },
                                        selectionShape:
                                            DateRangePickerSelectionShape
                                                .rectangle,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            DateTimeLine(
              controller: dateController,
              visibleDate: (date) {
                selectedDate.value = date;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
