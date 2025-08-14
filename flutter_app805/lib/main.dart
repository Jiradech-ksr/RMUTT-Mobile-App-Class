import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Date Time Picker'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              elevation: 10,
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: const Icon(Icons.event),
                dateLabelText: 'วันที่',   // "Date" in Thai
                timeLabelText: 'เวลา',     // "Time" in Thai
                onChanged: (val) => print(val),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
