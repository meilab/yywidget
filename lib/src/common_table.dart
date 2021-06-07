import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class MyDataColumn {
  String title;
  Function render;

  MyDataColumn({required this.title, required this.render});
}

class CommonTable extends StatelessWidget {
  final onLoadMore;
  final onRefresh;
  final List<MyDataColumn> dataColumns;
  final List<dynamic> data;
  final EasyRefreshController controller;
  CommonTable(
      {required this.onLoadMore,
      required this.onRefresh,
      required this.dataColumns,
      required this.data,
      required this.controller});

  List<DataRow> _renderRow() {
    final List<DataRow> rows = data.map<DataRow>((dynamic item) {
      return DataRow(
        cells: dataColumns
            .map<DataCell>((MyDataColumn columnItem) => columnItem.render(item))
            .toList(),
      );
    }).toList();

    return rows;
  }

  List<DataColumn> _renderColumn(BuildContext context) => dataColumns
      .map((MyDataColumn item) => DataColumn(
            label:
                Text(item.title, style: Theme.of(context).textTheme.headline4),
          ))
      .toList();

  Widget _renderDataTable(BuildContext context) => Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DataTable(
                  // horizontalMargin: 0.0,
                  columnSpacing: 8,
                  columns: _renderColumn(context),
                  rows: _renderRow(),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      firstRefresh: true,
      child: _renderDataTable(context),
      onRefresh: () async {
        onRefresh();
      },
      onLoad: () async {
        onLoadMore();
      },
      header: MaterialHeader(),
      footer: MaterialFooter(),
    );
  }
}
