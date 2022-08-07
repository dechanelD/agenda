import 'package:agenda/services/theme_service.dart';
import 'package:agenda/ui/add_task_bar.dart';
import 'package:agenda/ui/theme.dart';
import 'package:agenda/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '';

import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate=DateTime.now();
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
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Themes.primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),

        ),
        onDateChange: (date){
          _selectedDate = date;

        },
      ),
    );
  }

  _addTaskBar(){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: textHeadingStyle,
                ),
                Text("Aujourd'hui",
                  style: headingStyle,),

              ],
            ),
          ),
          Mybutton(label: "+ Ajouter", onTap: ()=>Get.to(AddTAskPAge())),
        ],
      ),
    );
  }

  _appBar(){
    return  AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title:"Notification theme changed",
            body: Get.isDarkMode?"Mode sombre activé":"Mode clair activé",
          );
        },
        child: Icon(Get.isDarkMode?Icons.wb_sunny_outlined:Icons.nightlight_round,
        size: 20,
          color: Get.isDarkMode? Colors.white:Colors.black,
        ),
      ),
      actions: [
         Icon(Icons.person,
          size: 20,
           color: Get.isDarkMode? Colors.white:Colors.black,
        ),
        SizedBox(width:20),
      ],
    );
  }
}
