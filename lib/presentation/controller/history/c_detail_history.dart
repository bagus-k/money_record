import 'dart:convert';

import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CDetailHistory extends GetxController {
  final _data = History().obs;
  History get data => _data.value;

  getData(id_user, date, type) async {
    History? history = await SourceHistory.detail(id_user, date, type);
    _data.value = history ?? History();
    update();
  }
}
