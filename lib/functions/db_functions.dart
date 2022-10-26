import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_record/model/data_model.dart';


ValueNotifier<List<StudentModel>> studentListNotifier =ValueNotifier([]);
RxList<StudentModel> searchData = <StudentModel>[].obs;

Future<void> addStudent(StudentModel value) async{
final studentDB = await Hive.openBox<StudentModel>('student_db');
final id = await studentDB.add(value);
value.id = id;
studentDB.put(value.id,value);
// studentListNotifier.value.add(value); 
 studentListNotifier.notifyListeners();

}

Future<void> getAllStudents() async{

final studentDB = await Hive.openBox<StudentModel>('student_db');
studentListNotifier.value.clear();
studentListNotifier.value.addAll(studentDB.values); 
studentListNotifier.notifyListeners();  
}

Future<void> deleteStudent(int id) async{
   final studentDB = await Hive.openBox<StudentModel>('student_db');
   studentDB.delete(id);
   studentListNotifier.notifyListeners();
  await getAllStudents();
}


Future<void> updateStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
   studentDB.put(value.id ,value);
   await getAllStudents();
}   

getSearchResult(String value) {
  searchData.clear();
  for (var index in studentListNotifier.value) {
    if (index.name.toString().toLowerCase().contains(
          value.toLowerCase(),
        )) {
      StudentModel data = StudentModel(
        name: index.name,
        age: index.age,
        stnd: index.stnd,
        reg: index.reg,
        img: index.img,
      );
      searchData.add(data);
    }
  }
}
