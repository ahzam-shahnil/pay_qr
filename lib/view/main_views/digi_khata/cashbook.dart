import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';
import 'package:pay_qr/widgets/digi_khata/pluto_header.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CashBook extends StatefulWidget {
  const CashBook({Key? key}) : super(key: key);

  @override
  State<CashBook> createState() => _CashBookState();
}

class _CashBookState extends State<CashBook> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
        title: 'Date',
        field: 'date',
        type: PlutoColumnType.text(),
        cellPadding: 15,
        enableRowDrag: false,
        enableDropToResize: false,
        enableRowChecked: false,
        enableColumnDrag: false,
        readOnly: true,
        width: Get.size.width * 0.42,
        minWidth: Get.size.width * 0.2,
      ),
      PlutoColumn(
        title: 'Cash In',
        field: 'cashin',
        enableColumnDrag: false,
        readOnly: true,
        enableContextMenu: false,
        enableDropToResize: false,
        enableRowDrag: false,
        enableRowChecked: false,
        cellPadding: 15,
        minWidth: Get.size.width * 0.15,
        width: Get.size.width * 0.27,
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          Color textColor = Colors.red;

          return Text(
            rendererContext.cell.value.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Cash Out',
        readOnly: true,
        width: Get.size.width * 0.27,
        field: 'cashout',
        cellPadding: 15,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableContextMenu: false,
        enableRowDrag: false,
        enableRowChecked: false,
        minWidth: Get.size.width * 0.15,
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          Color textColor = Colors.green;
          return Text(
            rendererContext.cell.value.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    ]);
  }

  // String calculateCashOut(List<CashModel> records) {
  //   double total = 0;
  //   double diye = 0;

  //   for (var item in records) {
  //     //Todo: fix the model here
  //     // diye += item.diye;
  //   }
  //   return (total = total + diye).toString();
  // }

  // String calculateCashIn(List<CashModel> records) {
  //   double total = 0;
  //   double liye = 0;

  //   for (var item in records) {
  //     liye += item.paisay;
  //   }
  //   return (total = total + liye).toString();
  // }

  DateTime date = DateTime.now();
  late var formattedDate = DateFormat('d-MMM-yy').format(date);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: digiController.getCashBookStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: kScanBackColor,
          ));
        }

        if (snapshot.hasData) {
          var data = snapshot.data!.docs
              .map((e) => CashModel.fromSnapshot(e))
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: const [
                      Expanded(
                          child: ReuseableCard(
                        textColor: Colors.red,
                        backColor: kScanBackColor,
                        text: "Aaj ki Kamae",
                        description: '0',
                        isMaineLene: true,
                      )),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                          child: ReuseableCard(
                        backColor: kScanBackColor,
                        textColor: Colors.green,
                        text: "Moujouda Cash",
                        description: '0',
                        isMaineLene: false,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.size.height * 0.728,
                  child: PlutoGrid(
                    configuration: const PlutoGridConfiguration(
                      defaultCellPadding: 5,
                      defaultColumnTitlePadding: 5,
                      enableGridBorderShadow: true,
                      enableColumnBorder: true,
                      gridBorderRadius: BorderRadius.all(Radius.circular(12)),
                    ),

                    columns: columns,
                    rows: [
                      for (int i = 2; i >= 0; i--)
                        PlutoRow(
                          cells: {
                            'date': PlutoCell(value: i),
                            'cashin': PlutoCell(value: i),
                            'cashout': PlutoCell(value: i),
                          },
                        ),
                    ],
                    onChanged: (PlutoGridOnChangedEvent event) {
                      print(event);
                    },
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      event.stateManager
                          .setSelectingMode(PlutoGridSelectingMode.cell);

                      stateManager = event.stateManager;
                    },
                    createHeader: (stateManager) =>
                        PlutoHeader(stateManager: stateManager),
                    // configuration: PlutoConfiguration.dark(),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          color: kScanBackColor,
        ));
      },
    );
  }
}
