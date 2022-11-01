import 'dart:convert';

import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/controller/history/c_detail_history.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage(
      {super.key,
      required this.idUser,
      required this.date,
      required this.type});
  final String idUser, date, type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());
  final cuser = Get.put(CUser());

  @override
  void initState() {
    // TODO: implement initState
    cDetailHistory.getData(widget.idUser, widget.date, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() {
          if (cDetailHistory.data.date == null) return DView.nothing();
          return Row(
            children: [
              Expanded(
                child: Text(
                  AppFormat.date(cDetailHistory.data.date!),
                ),
              ),
              cDetailHistory.data.type == "Pemasukan"
                  ? Icon(
                      Icons.south_west,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.south_west,
                      color: Colors.red,
                    )
            ],
          );
        }),
      ),
      body: GetBuilder<CDetailHistory>(builder: (_) {
        if (_.data.date == null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          if (widget.date == today && widget.type == 'Pengeluaran') {
            return DView.empty('Belum ada Pengeluaran');
          }
          return DView.nothing();
        }
        List details = jsonDecode(_.data.details!);
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DView.spaceHeight(),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Total',
              style: TextStyle(
                color: AppColor.primary.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text(
              AppFormat.currency(_.data.total!),
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AppColor.primary,
                  ),
            ),
          ),
          Center(
            child: Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColor.bg, borderRadius: BorderRadius.circular(30)),
            ),
          ),
          DView.spaceHeight(20),
          Expanded(
            child: ListView.separated(
                itemCount: details.length,
                separatorBuilder: ((context, index) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      thickness: 0.5,
                    )),
                itemBuilder: (context, index) {
                  Map item = details[index];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: const TextStyle(fontSize: 20),
                        ),
                        DView.spaceWidth(8),
                        Expanded(
                            child: Text(
                          item['name'],
                          style: const TextStyle(fontSize: 20),
                        )),
                        Text(
                          AppFormat.currency(item['price']),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ]);
      }),
    );
  }
}
