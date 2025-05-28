import 'dart:io';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class ExcellFileImport extends StatefulWidget {
  const ExcellFileImport({super.key});

  @override
  State<ExcellFileImport> createState() => _ExcellFileImportState();
}

class _ExcellFileImportState extends State<ExcellFileImport> {
  List<List<String>> _excelData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _excelData.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(_excelData[index].join(' | ')));
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        _pickAndReadExcelFile();
      }),
    );
  }

  Future<void> _pickAndReadExcelFile() async {
    _excelData.clear();

    /// Use FilePicker to pick files in Flutter Web

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    /// file might be picked

    if (pickedFile != null) {
      var bytes = pickedFile.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxColumns);
        print(excel.tables[table]!.maxRows);
        for (var row in excel.tables[table]!.rows) {
          _excelData
              .add(row.map((cell) => cell?.value.toString() ?? '').toList());
          print('$row');
        }
      }
      _excelData.removeAt(0);
      setState(() {});
    }
  }
}
