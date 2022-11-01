import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';

class CIncomeOutcome extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <History>[].obs;
  List<History> get list => _list.value;

  getList(id_user, type) async {
    _loading.value = true;
    update();

    _list.value = await SourceHistory.getIncomeOutcome(id_user, type);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  getSearch(id_user, type, date) async {
    _loading.value = true;
    update();

    _list.value =
        await SourceHistory.getIncomeOutcomeSearch(id_user, type, date);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }
}
