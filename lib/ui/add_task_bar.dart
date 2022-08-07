import 'package:agenda/controllers/task_controller.dart';
import 'package:agenda/ui/theme.dart';
import 'package:agenda/ui/widgets/button.dart';
import 'package:agenda/ui/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../services/theme_service.dart';

class AddTAskPAge extends StatefulWidget {
  const AddTAskPAge({Key? key}) : super(key: key);

  @override
  State<AddTAskPAge> createState() => _AddTAskPAgeState();
}

class _AddTAskPAgeState extends State<AddTAskPAge> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "11:50 PM";
  int _selectedRemin = 5;
  List<int> reminList=[
    5,
    10,
    15,
    20
    ];

  String _selectedRepeat = "Jamais";
  List<String> repeatList=[
    "Jamais",
    "Jouranalier",
    "Hebdomadaire",
    "Mensuel",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                  "Ajouter une tache",
                style: headingStyle,
              ),
              MyInputField(title: "Titre", placeHolder: "ajoutez un titre",controller: _titleController,),
              MyInputField(title: "Note", placeHolder: "Entrez votre note",controller: _noteController,),
              MyInputField(title: "Date", placeHolder: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                onPressed: (){
                  print("yo");
                  _getDateFromUser();

                },
                icon: Icon(Icons.calendar_today_outlined, color: Colors.grey,),
              ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                          title: "Debut",
                          placeHolder: _startTime,
                          widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStartTime: true);

                            },
                            icon: Icon(Icons.access_time_rounded, color: Colors.grey,),
                          ),
                      ),


                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(
                      title: "Fin",
                      placeHolder: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: false);

                        },
                        icon: Icon(Icons.access_time_rounded, color: Colors.grey,),
                      ),
                    ),


                  )
                ],
              ),
              MyInputField(title: "Rappel", placeHolder: _selectedRemin.toString()+" Apres",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: textHeadingStyle,
                underline: Container(height: 0,),
                items: reminList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    child: Text(value.toString()),
                    value: value.toString(),
                  );
                }).toList(),

                onChanged: (String? newValue) {
                  setState((){
                    _selectedRemin = int.parse(newValue!);
                  });
                },
              ),

              ),
              MyInputField(title: "Repeter", placeHolder: _selectedRepeat,
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: textHeadingStyle,
                  underline: Container(height: 0,),
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      child: Text(value!, style: TextStyle(color: Colors.grey),),
                      value: value,
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState((){
                      _selectedRepeat = newValue!;
                    });
                  },
                ),

              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPriority(),
                  Mybutton(label: "Creer la tache", onTap: ()=>_validateData()),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  _addTaskToDb() async {

  int value =  await _taskController.addTask(
       task: Task(
         note: _noteController.text,
         title:_titleController.text,
         date:DateFormat.yMd().format(_selectedDate),
         startTime:_startTime,
         endTime:_endTime,
         remind:_selectedRemin,
         repeat:_selectedRepeat,
         color:_selectedColor,
         isCompleted:0,
       )
   );
  print("mon id est "+"$value");
  }

  _validateData() {
    if (_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty) {
      //ajouter a la bd
      _addTaskToDb();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Erreur", " Veuillez remplir tous les champ",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: Icon(Icons.warning_amber_rounded,
        color: Colors.red,),
      );
    }
  }

  _colorPriority(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Priorite",
          style: titleStyle,
        ),
        SizedBox(height: 5.0,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState((){
                      _selectedColor = index;
                    });
                  },

                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?Colors.green:index==1?Colors.red:Themes.yellowClr,
                      child: _selectedColor == index? Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      ):Container(),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
  _appBar(){
    return  AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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

  _getDateFromUser() async {

    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if(_pickerDate!=null){
      setState((){
        _selectedDate = _pickerDate;
      });
    }else{
      print("Erreur");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var picketTime = await _showTimePicker();
    String _formatTime = picketTime.format(context);
    if(picketTime==null){
      print("temps ecoule");
    }else if(isStartTime==true){
      setState((){
        _startTime = _formatTime;
      });
    }else if(isStartTime==false){
       setState((){
         _endTime = _formatTime;
       });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        //format d'affichage 10:30 AM 
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

}
