import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:students_record/model/data_model.dart';

class ScreenOntap extends StatelessWidget {
    final StudentModel studentModel;

  const ScreenOntap({super.key, required this.studentModel});


  @override
  Widget build(BuildContext context) {
        final data = studentModel;
        final enc =data.img;
          final img = const Base64Decoder().convert(enc.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(studentModel.name),
      ),
      body:  Center(
        child: Column(
            children: [
              const SizedBox(height: 100),
              CircleAvatar(
                radius: 80,
               backgroundImage: MemoryImage(img)),
              const   SizedBox(height: 15,),
                     Text('NAME : ${studentModel.name}',style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),),
                     Text('AGE : ${studentModel.age}',style: const TextStyle(
                  fontWeight: FontWeight.bold,
                   fontSize: 25
                ),),
                  Text('CLASS : ${studentModel.stnd}',style: const TextStyle(
                  fontWeight: FontWeight.bold,
                   fontSize: 25
                ),),
                   Text('REGISTER NO. : ${studentModel.reg}',style: const TextStyle(
                  fontWeight: FontWeight.bold,
                   fontSize: 25
                ),),
                ],
               )
             ),
           );
         }
       }