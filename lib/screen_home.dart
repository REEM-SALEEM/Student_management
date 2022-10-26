import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:students_record/functions/db_functions.dart';
import 'package:students_record/screen_add.dart';
import 'package:students_record/screen_edit.dart';
import 'package:students_record/screen_ontap.dart';
import 'package:students_record/screen_search.dart';
import 'model/data_model.dart';


class ScreenHome extends StatefulWidget {


  const ScreenHome({super.key});
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    
    getAllStudents();

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Student details'),
        actions: [
           IconButton(
              onPressed: () {
                searchData.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScreenSearch()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
     body: Column(
      children: [
        ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList, Widget? child){
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index){
                final data = studentList[index];
                final enc =data.img;
                log(enc.toString());
              final img = const Base64Decoder().convert(enc.toString());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(color: Colors.amber,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: MemoryImage(img)
                        // 
                        ),
                     title: Text(data.name),
                     subtitle: Text(data.age),
                     onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ScreenOntap(studentModel: data,)));
                     }, 
                     trailing: SizedBox(
                      width: 100.0,
                    
                       child: Row(
                         children: [
                           IconButton(onPressed: (){
                            setState(() {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ScreenView(studentModel:data)));
                            });
                          
                           }, 
                           icon:const Icon(Icons.edit)),
                           IconButton(onPressed: (){
                            if(data.id != null){
                                    deleteStudent(data.id!);
                            }
                            else{
                              // print('student is null, unable to delete');
                            }
                          
                           }, icon:const Icon(Icons.delete),color: Colors.black,),
                         ],
                       ),
                     ) ,
                    ),
                  ),
                );
              },
               separatorBuilder: (context, index){
                return const Divider();
               },
                itemCount: studentList.length,
                ),
          );
          },
        )
      ],
     ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>const ScreenAdd()));
          
        },
      ),
    );
  }
}
