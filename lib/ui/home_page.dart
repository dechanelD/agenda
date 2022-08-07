import 'package:agenda/services/theme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initialiseNotification;
    notifyHelper.requestIOSPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text("Theme",
          style: TextStyle(
            fontSize: 30
          ),
          )
        ],
      ),
    );
  }

  _appBar(){
    return  AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title:"Notification theme changed",
            body: Get.isDarkMode?"Mode sombre activé":"Mode clair activé",
          );
        },
        child: Icon(Icons.nightlight_round,
        size: 20,
        ),
      ),
      actions: [
         Icon(Icons.person,
          size: 20,
        ),
        SizedBox(width:20),
      ],
    );
  }
}
