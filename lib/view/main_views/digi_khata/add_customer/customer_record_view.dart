import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';
import 'package:pay_qr/widgets/digi_khata/amount_card.dart';
import 'package:pay_qr/widgets/digi_khata/pluto_header.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../config/controllers.dart';
import '../../../../model/customer.dart';
import 'add_customers_record.dart';

class CustomerRecordsView extends StatefulWidget {
  const CustomerRecordsView({Key? key, required this.customer})
      : super(key: key);
  final CustomerModel customer;
  @override
  State<CustomerRecordsView> createState() => _CustomerRecordsViewState();
}

class _CustomerRecordsViewState extends State<CustomerRecordsView> {
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
        title: 'Maine Diye',
        field: 'diye',
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
        title: 'Maine Liye',
        readOnly: true,
        width: Get.size.width * 0.27,
        field: 'liye',
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

  // @override
  // void dispose() {
  //   Future.delayed(Duration.zero, () {
  //     amountController.resetData();
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        amountController.resetData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const DigiNavHome(selectedScreen: 0)),
        );
        return true;
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            widget.customer.name,
            style: Get.textTheme.headline6,
          ),
          actions: const [],
        ),
        body: FutureBuilder(
          future: digiController.getCustomerSpecificRecord(widget.customer.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasData) {
              var data = snapshot.data as CustomerModel;
              var cashRecords = data.cashRecords;
              cashRecords.sort((a, b) => a.date.compareTo(b.date));
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 80, top: 10, bottom: 10),
                          child: AmountCard(
                            totalAmount: Utility.calculateAmount(cashRecords)
                                .toStringAsFixed(0),
                          ),
                        ),
                        Expanded(
                          child: PlutoGrid(
                            onSelected: ((event) =>
                                logger.i(event.row?.cells.values)),

                            onRowDoubleTap: ((event) {
                              var record =
                                  CashModel.fromPlutoCell(event.row?.cells);
                              logger.d(record);
                              Get.to(() => AddCustomerRecord(
                                    customer: widget.customer,
                                    isFromCashBook: false,
                                    record: record,
                                    isMainDiye: record.isMainDiye,
                                    cashRecords: cashRecords,
                                  ));
                            }),
                            configuration: PlutoGridConfiguration(
                              defaultCellPadding: 10,
                              defaultColumnTitlePadding: 5,
                              rowHeight: Get.size.width * 0.15,
                              enableGridBorderShadow: true,
                              enableColumnBorder: true,
                              gridBorderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),

                            columns: columns,
                            rows: [
                              for (int i = cashRecords.length - 1; i >= 0; i--)
                                PlutoRow(
                                  sortIdx: i,
                                  cells: {
                                    'date': PlutoCell(
                                      value:
                                          '${Utility.getFormatedDate(DateTime.parse(cashRecords[i].date))}#${cashRecords[i].details}',
                                    ),
                                    'diye': PlutoCell(
                                        value: cashRecords[i].isMainDiye
                                            ? cashRecords[i].paisay.toString()
                                            : '0'),
                                    'liye': PlutoCell(
                                        value: cashRecords[i].isMainDiye ==
                                                false
                                            ? cashRecords[i].paisay.toString()
                                            : '0'),
                                  },
                                ),
                            ],
                            onChanged: (PlutoGridOnChangedEvent event) {
                              print(event);
                            },
                            onLoaded: (PlutoGridOnLoadedEvent event) {
                              event.stateManager.setSelectingMode(
                                  PlutoGridSelectingMode.cell);

                              stateManager = event.stateManager;
                            },
                            createHeader: (stateManager) => PlutoHeader(
                              stateManager: stateManager,
                              title: widget.customer.name,
                            ),
                            // configuration: PlutoConfiguration.dark(),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ReusableButton(
                                color: Colors.red,
                                text: "Diye",
                                onpress: () {
                                  Get.to(() => AddCustomerRecord(
                                        customer: widget.customer,
                                        isMainDiye: true,
                                        isFromCashBook: false,
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.size.width * 0.02,
                            ),
                            Expanded(
                              child: ReusableButton(
                                color: Colors.green,
                                text: "Liye",
                                onpress: () {
                                  Get.to(() => AddCustomerRecord(
                                        customer: widget.customer,
                                        isMainDiye: false,
                                        isFromCashBook: false,
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
