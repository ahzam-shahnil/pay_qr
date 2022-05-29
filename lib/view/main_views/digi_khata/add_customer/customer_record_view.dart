
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/widgets/digi_khata/amount_card.dart';
import 'package:pay_qr/widgets/digi_khata/pluto_header.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';
import 'package:pluto_grid/pluto_grid.dart';


import '../../../../config/controllers.dart';
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
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // resizeToAvoidBottomInset: true,
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
                          totalAmount: Utility.calculateAmount(data.cashRecords)
                              .toStringAsFixed(0),
                        ),
                      ),
                      Expanded(
                        child: PlutoGrid(
                          configuration: const PlutoGridConfiguration(
                            defaultCellPadding: 5,
                            defaultColumnTitlePadding: 5,
                            enableGridBorderShadow: true,
                            enableColumnBorder: true,
                            gridBorderRadius:
                                BorderRadius.all(Radius.circular(12)),
                          ),

                          columns: columns,
                          rows: [
                            for (int i = data.cashRecords.length - 1;
                                i >= 0;
                                i--)
                              PlutoRow(
                                cells: {
                                  'date': PlutoCell(
                                    value:
                                        '${data.cashRecords[i].date}\n${data.cashRecords[i].details}',
                                  ),
                                  'diye': PlutoCell(
                                      value: data.cashRecords[i].isMainDiye
                                          ? data.cashRecords[i].paisay
                                              .toString()
                                          : '0'),
                                  'liye': PlutoCell(
                                      value: data.cashRecords[i].isMainDiye ==
                                              false
                                          ? data.cashRecords[i].paisay
                                              .toString()
                                          : '0'),
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
    );
  }
}
