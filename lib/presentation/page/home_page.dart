import 'package:course_money_record/config/session.dart';
import 'package:course_money_record/presentation/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home Page'),
          IconButton(
              onPressed: () {
                Session.clearUser();
                Get.off(() => const LoginPage());
              },
              icon: const Icon(Icons.logout)),
        ],
      )),
    );
  }
}
