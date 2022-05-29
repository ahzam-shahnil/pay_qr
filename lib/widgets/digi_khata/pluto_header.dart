import 'dart:convert';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;

class PlutoHeader extends StatefulWidget {
  const PlutoHeader({
    required this.stateManager,
    Key? key,
  }) : super(key: key);

  final PlutoGridStateManager stateManager;

  @override
  State<PlutoHeader> createState() => _PlutoHeaderState();
}

class _PlutoHeaderState extends State<PlutoHeader> {
  void _printToPdfAndShareOrSave() async {
    var plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
      title: "Pluto Grid Sample pdf print",
      creator: "Pluto Grid Rocks!",
      format: pluto_grid_export.PdfPageFormat.a4.landscape,
    );

    await pluto_grid_export.Printing.sharePdf(
        bytes: await plutoGridPdfExport.export(widget.stateManager),
        filename: plutoGridPdfExport.getFilename());
  }

  void _defaultExportGridAsCSV() async {
    String title = "pluto_grid_export";
    var exported = const Utf8Encoder().convert(
        pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager));
    await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
  }

  void _defaultExportGridAsCSVCompatibleWithExcel() async {
    String title = "pluto_grid_export";
    var exportCSV =
        pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager);
    var exported = const Utf8Encoder().convert('\u{FEFF}$exportCSV');
    await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: widget.stateManager.headerHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                  onPressed: _printToPdfAndShareOrSave,
                  child: const Text("Print to PDF and Share")),
              ElevatedButton(
                  onPressed: _defaultExportGridAsCSV,
                  child: const Text("Export to CSV")),
              ElevatedButton(
                  onPressed: _defaultExportGridAsCSVCompatibleWithExcel,
                  child: const Text("UTF-8 CSV compatible with MS Excel")),
            ],
          ),
        ),
      ),
    );
  }
}
