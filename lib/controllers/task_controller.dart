import 'package:agenda/db/db_helper.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  var taskLList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskLList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
   await DBHelper.update(id);
   getTasks();
  }

}