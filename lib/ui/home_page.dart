import 'package:agenda/controllers/task_controller.dart';
import 'package:agenda/models/task.dart';
import 'package:agenda/services/theme_service.dart';
import 'package:agenda/ui/add_task_bar.dart';
import 'package:agenda/ui/theme.dart';
import 'package:agenda/ui/widgets/button.dart';
import 'package:agenda/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  final _taskController = Get.put(TaskController());
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
          SizedBox(height: 10,),
          //_showTask(),
        ],
      ),
    );
  }

  /*_showTask(){
    return Expanded(
        child: Obx((){
           return ListView.builder(
               itemCount: _taskController.taskLList.length,
               itemBuilder: (_, index){
               //print(_taskController.taskLList.length);
               Task task = _taskController.taskLList[index];
               if(task.repeat=='Journalier'){
                 return AnimationConfiguration.staggeredList(
                     position: index,
                     child: SlideAnimation(
                       child: FadeInAnimation(
                         child: Row(
                           children: [
                             GestureDetector(
                               onTap: (){
                                 //print("toucheeeeee");
                                 _showBottomSheet(context, task);
                               },
                               child: TaskTile(task),
                             ),
                           ],
                         ),
                       ),
                     ));
               }
               if(task.date==DateFormat.yMd().format(_selectedDate)){
                 return AnimationConfiguration.staggeredList(
                     position: index,
                     child: SlideAnimation(
                       child: FadeInAnimation(
                         child: Row(
                           children: [
                             GestureDetector(
                               onTap: (){
                                 //print("toucheeeeee");
                                 _showBottomSheet(context, task);
                               },
                               child: TaskTile(task),
                             ),
                           ],
                         ),
                       ),
                     ));
               }else{
                 return Container();
               }


           });
        }),
    );
  }*/

  _showTask(){
    return Container(
      color: Colors.black,
    );
  }


  _bottomSheetButtun({
    required String label,
    required Color clr,
    required Function()? onTap,
    bool isClose = false,
    required BuildContext context
  }){
    GestureDetector(
      onTap: onTap,
      child: Container(
        margin:const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width:2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }


  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode?Themes.darkGreyClr:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted==1
            ?Container()
                :_bottomSheetButtun(
                label: "Tache Termine",
                clr: Themes.primaryClr,
                context:context,
                onTap: (){
                  _taskController.markTaskCompleted(task.id!);
                  Get.back();
                }),
            SizedBox(height: 20,),

            _bottomSheetButtun(
                label: "Supprimez la tache",
                clr: Colors.red[300]!,
                context:context,
                onTap: (){
                  _taskController.delete(task);
                  Get.back();
                }),
            SizedBox(height: 20,),
            _bottomSheetButtun(
                label: "Fermez",
                clr: Colors.red[300]!,
                isClose: true,
                context:context,
                onTap: (){
                  Get.back();
                }),
            SizedBox(height: 10,),
          ],
        ),
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
          setState((){
            _selectedDate = date;
          });

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
          Mybutton(label: "+ Ajouter", onTap: () async {
            await Get.to(()=>AddTAskPAge());
            _taskController.getTasks();
          }
          ),
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
