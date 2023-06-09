import 'dart:convert';
import 'dart:io';
import 'package:employees/ui/table.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/theme_helper.dart';
import '../models/employee.dart';
import 'components/button.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  List<List<dynamic>> data = List.empty(growable: true);
  List<Employee> employeeList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        icon: Icons.upload,
        text: "Upload",
        onPressed: () async {
          await loadAsset();
        },
      ),
      appBar: AppBar(
        backgroundColor: ThemeHelper.backgroundColor,
        title: const Text('Employees',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
      ),
      body: SingleChildScrollView(
          child: data.isNotEmpty
              ? TableLayout(employeeList: employeeList, data: data)
              : buildRequirements()),
    );
  }

  Future<void> loadAsset() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> bytes = await file.readAsBytes();
      List<List<dynamic>> csvTable =
          const CsvToListConverter(fieldDelimiter: ';')
              .convert(utf8.decode(bytes));
      print(csvTable);
      try {
        employeeList = List<Employee>.from(
          csvTable.sublist(1).map(
                (row) => Employee.fromCsv(
                  '${row[0]};${row[1]};${row[2]};${row[3]}',
                ),
              ),
        );
        setState(() {
          data = csvTable;
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        Navigator.of(context).pop();
      }
    }
  }

  Widget buildRequirements() {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const Text("Please load a CSV file.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            const Text("The file should have the following format:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            const SizedBox(height: 10),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: const [
                ListTile(
                  title: Text('EmpID'),
                  leading: Icon(Icons.person),
                  trailing: Text('Employee ID (int)'),
                ),
                ListTile(
                  title: Text('ProjectID'),
                  leading: Icon(Icons.work),
                  trailing: Text('Project ID (int)'),
                ),
                ListTile(
                  title: Text('DateFrom'),
                  leading: Icon(Icons.date_range),
                  trailing: Text('Starting date'),
                ),
                ListTile(
                  title: Text('DateTo'),
                  leading: Icon(Icons.date_range_outlined),
                  trailing: Text('Ending date'),
                ),
              ],
            )
          ],
        ));
  }
}
