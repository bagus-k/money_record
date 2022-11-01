import 'dart:collection';

import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/data/model/history.dart';
import 'package:d_info/d_info.dart';
import 'package:intl/intl.dart';

import '../../config/app_request.dart';

class SourceHistory {
  static Future<Map> analysis(String id_user) async {
    String url = "${Api.history}/analysis.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id_user,
      "today": DateFormat('yyyy-MM-dd').format(DateTime.now())
    });

    if (responseBody == null) {
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {'income': 0.0, 'outcome': 0.0}
      };
    }
    return responseBody;
  }

  static Future<bool> add(String id_user, String date, String type,
      String details, String total) async {
    String url = "${Api.history}/add.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id_user,
      'date': date,
      'type': type,
      'details': details,
      "total": total,
      "created_at": DateTime.now().toIso8601String(),
      "updated_at": DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess("Berhasil Tambah History");
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError("History pada tanggal tersebut sudah terdaftar");
      } else {
        DInfo.dialogError("Gagal Tambah History");
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }

  static Future<List<History>> getIncomeOutcome(
      String id_user, String type) async {
    String url = "${Api.history}/income_outcome.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id_user,
      'type': type,
    });

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List<History>> getIncomeOutcomeSearch(
      String id_user, String type, String date) async {
    String url = "${Api.history}/income_outcome_search.php";
    Map? responseBody = await AppRequest.post(
        url, {'id_user': id_user, 'type': type, 'date': date});

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }

  static Future<History?> whereDate(String id_user, String date) async {
    String url = "${Api.history}/where_date.php";
    Map? responseBody =
        await AppRequest.post(url, {'id_user': id_user, 'date': date});

    if (responseBody == null) {
      return null;
    }

    if (responseBody['success']) {
      var e = responseBody['data'];
      return History.fromJson(e);
    }
    return null;
  }

  static Future<bool> update(String idHistory, String id_user, String date,
      String type, String details, String total) async {
    String url = "${Api.history}/update.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_history': idHistory,
      'id_user': id_user,
      'date': date,
      'type': type,
      'details': details,
      "total": total,
      "updated_at": DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess("Berhasil Update History");
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError("Tanggal History tidak bisa diubah");
      } else {
        DInfo.dialogError("Gagal Tambah History");
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }

  static Future<bool> delete(String idHistory) async {
    String url = "${Api.history}/delete.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_history': idHistory,
    });

    if (responseBody == null) return false;

    return responseBody['success'];
  }

  static Future<List<History>> getHistory(String id_user) async {
    String url = "${Api.history}/history.php";
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id_user,
    });

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List<History>> historySearch(
      String id_user, String date) async {
    String url = "${Api.history}/history_search.php";
    Map? responseBody =
        await AppRequest.post(url, {'id_user': id_user, 'date': date});

    if (responseBody == null) {
      return [];
    }

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }
}
