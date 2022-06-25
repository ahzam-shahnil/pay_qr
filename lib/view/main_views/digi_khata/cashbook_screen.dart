import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/view/main_views/digi_khata/add_customer/add_customers_record.dart';
import 'package:pay_qr/widgets/digi_khata/cashbook_amount_row.dart';
import 'package:pay_qr/widgets/digi_khata/pluto_header.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CashBookScreen extends StatefulWidget {
  const CashBookScreen({Key? key}) : super(key: key);

  @override
  State<CashBookScreen> createState() => _CashBookScreenState();
}

class _CashBookScreenState extends State<CashBookScreen> {
  final List<PlutoColumn> columns = [];

  final List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  @override
  void reassemble() {
    super.reassemble();
    // Future.delayed(Duration.zero, () {
    //   cashbookController.resetData();
    // });

    logger.d('ON resAssemble');
  }

  // @override
  // void dispose() {
  //   Future.delayed(Duration.zero, () {
  //     cashbookController.resetData();
  //   });
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
          title: 'ID',
          readOnly: true,
          width: 0,
          field: 'id',
          cellPadding: 15,
          hide: true,
          enableColumnDrag: false,
          enableDropToResize: false,
          enableContextMenu: false,
          enableRowDrag: false,
          enableRowChecked: false,
          type: PlutoColumnType.text(),
          renderer: (rendererContext) {
            String text = rendererContext.cell.value.toString();
            return Text(
              text,
              style: Get.textTheme.bodySmall?.copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            );
          }),
      PlutoColumn(
          title: 'Date',
          field: 'date',
          type: PlutoColumnType.text(),
          cellPadding: 20,
          enableRowDrag: false,
          enableDropToResize: false,
          enableRowChecked: false,
          enableColumnDrag: false,
          readOnly: true,
          // enableSorting: true,
          width: kWidth * 0.42,
          minWidth: kWidth * 0.2,
          renderer: (rendererContext) {
            String text = rendererContext.cell.value.toString();
            return RichText(
              text: TextSpan(
                  text: '${text.substring(0, text.indexOf('#'))}\n',
                  style:
                      Get.textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
                  children: [
                    TextSpan(
                        text: text.substring(
                            text.indexOf('#') + 1, text.length - 1),
                        style: Get.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black))
                  ]),
            );
          }),
      PlutoColumn(
        title: 'Cash In',
        field: 'cashin',
        enableColumnDrag: false,
        readOnly: true,
        enableContextMenu: false,
        enableDropToResize: false,
        enableRowDrag: false,
        enableRowChecked: false,
        cellPadding: 20,
        minWidth: kWidth * 0.15,
        width: kWidth * 0.27,
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
      PlutoColumn(
        title: 'Cash Out',
        readOnly: true,
        width: kWidth * 0.27,
        field: 'cashout',
        cellPadding: 20,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableContextMenu: false,
        enableRowDrag: false,
        enableRowChecked: false,
        minWidth: kWidth * 0.15,
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
    ]);
  }

  DateTime date = DateTime.now();

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
          //? calculating total here
          // cashbookController.calculateTotalHisaab(data);
          // data.isEmpty ? cashbookController.resetData() : null;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                CashBookAmountRow(
                  total: Utility.calculateAmount(data),
                 
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kScanBackColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  height: kHeight * 0.66,
                  child: PlutoGrid(
                    configuration: PlutoGridConfiguration(
                      gridBackgroundColor: Colors.transparent,
                      gridBorderColor: Colors.transparent,
                      defaultCellPadding: 10,
                      defaultColumnTitlePadding: 5,
                      enableGridBorderShadow: true,
                      rowHeight: kWidth * 0.15,
                      enableColumnBorder: true,
                      gridBorderRadius:
                          const BorderRadius.all(Radius.circular(12)),
                    ),
                    onRowDoubleTap: ((event) {
                      var record =
                          CashModel.fromCashBookPlutoCell(event.row?.cells);
                      Get.to(() => AddCustomerRecord(
                            isFromCashBook: true,
                            record: record,
                            isMainDiye: record.isMainDiye,
                          ));
                    }),
                    columns: columns,
                    rows: [
                      for (int i = 0; i < data.length; i++)
                        PlutoRow(
                          sortIdx: i,
                          cells: {
                            'id': PlutoCell(value: data[i].id),
                            'date': PlutoCell(
                              value:
                                  '${Utility.getFormatedDate(DateTime.parse(data[i].date))}#${data[i].details}',
                            ),
                            'cashin': PlutoCell(
                                value: data[i].isMainDiye == false
                                    ? data[i].paisay.toString()
                                    : '0'),
                            'cashout': PlutoCell(
                                value: data[i].isMainDiye
                                    ? data[i].paisay.toString()
                                    : '0'),
                          },
                        ),
                    ],
                    onChanged: (PlutoGridOnChangedEvent event) {
                      logger.d(event);
                    },
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      event.stateManager
                          .setSelectingMode(PlutoGridSelectingMode.cell);
                      // profileController.getProfile();

                      stateManager = event.stateManager;
                    },
                    createHeader: (stateManager) => PlutoHeader(
                      stateManager: stateManager,
                      title:
                          userController.userModel.value.fullName ?? kAppName,
                    ),
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
