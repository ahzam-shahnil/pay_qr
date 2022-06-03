import 'dart:convert';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;

class PlutoHeader extends StatefulWidget {
  final String title;
  const PlutoHeader({
    required this.stateManager,
    Key? key,
    required this.title,
  }) : super(key: key);

  final PlutoGridStateManager stateManager;

  @override
  State<PlutoHeader> createState() => _PlutoHeaderState();
}

class _PlutoHeaderState extends State<PlutoHeader> {
  void _printToPdfAndShareOrSave(String title) async {
    var plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
      title: title,
      creator: "PayQr Rocks!",
      format: pluto_grid_export.PdfPageFormat.a4.landscape,
    );

    await pluto_grid_export.Printing.sharePdf(
        bytes: await plutoGridPdfExport.export(widget.stateManager),
        filename: plutoGridPdfExport.getFilename());
  }

  void _defaultExportGridAsCSV(String title) async {
    var exported = const Utf8Encoder().convert(
        pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager));
    await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
  }

  // void _defaultExportGridAsCSVCompatibleWithExcel(String title) async {
  //   // String title = "pluto_grid_export";
  //   var exportCSV =
  //       pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager);
  //   var exported = const Utf8Encoder().convert('\u{FEFF}$exportCSV');
  //   await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: widget.stateManager.headerHeight,
        child: Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
                onPressed: () => _printToPdfAndShareOrSave(widget.title),
                child: const Text("Print to PDF and Share")),
            ElevatedButton(
                onPressed: () => _defaultExportGridAsCSV(widget.title),
                child: const Text("Export to CSV")),
            // ElevatedButton(
            //     onPressed: _defaultExportGridAsCSVCompatibleWithExcel(),
            //     child: const Text("UTF-8 CSV compatible with MS Excel")),
          ],
        ),
      ),
    );
  }
}
