import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_record/functions/db_functions.dart';
import 'package:students_record/model/data_model.dart';
import 'package:students_record/screen_home.dart';


class ScreenView extends StatefulWidget {
  final StudentModel studentModel;

  const   ScreenView({super.key, required this.studentModel});

  @override
  State<ScreenView> createState() => _ScreenViewState();
}

class _ScreenViewState extends State<ScreenView> {

  dynamic img;
  File? imageSelect ;

 final _nameformController = TextEditingController();
 final _ageformController = TextEditingController();
 final _stndformController = TextEditingController();
 final _regformController = TextEditingController();
 final _imagePicker = ImagePicker(); 
 dynamic imag;

  @override
  Widget build(BuildContext context) {
   imag = widget.studentModel.img;
  _nameformController.text= widget.studentModel.name;
  _ageformController.text = widget.studentModel.age;
  _stndformController.text = widget.studentModel.stnd;
  _regformController.text = widget.studentModel.reg;
  
   final formkey = GlobalKey<FormState>();
   



     return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.studentModel.name), 
        ),
         body: Padding(
          padding:const EdgeInsets.all(25),
          
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageSelect == null?
                  AspectRatio(
                    aspectRatio: 2,
                   child: Container(
                          decoration:
                           BoxDecoration(
                             image: DecorationImage(
                               image: MemoryImage(const Base64Decoder().convert(widget.studentModel.img)),
                            fit: BoxFit.cover,
                             ),
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ) ,
                         child:
                            Padding(
                                   padding: const EdgeInsets.fromLTRB(125, 0, 0, 10),
                             child: Column(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                               children:[
                                IconButton(   //imageicon button
                                 onPressed: (){
                                    pickImageGallery();
                                  },
                                  icon: const Icon(Icons.add_a_photo),iconSize: 30,
                                ),
                                ]
                              ),
                            ),
                   ),
                  ) 
                  :
                  AspectRatio(aspectRatio: 2,
                    child:  Container(
                          decoration:
                           BoxDecoration(
                             image: DecorationImage(
                               image:FileImage((File(imageSelect!.path))),
                        fit: BoxFit.cover
                             ),
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ) ,
                         child:
                            Padding(
                                   padding: const EdgeInsets.fromLTRB(125, 0, 0, 10),
                             child: Column(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                               children:[
                                IconButton(   //imageicon button
                                 onPressed: (){
                                
                                  pickImageGallery();
                                  },
                                  icon: const Icon(Icons.add_a_photo),iconSize: 30,
                                ),
                                ]
                              ),
                            ),
                   )
                  ),
                  
      //Text                
                  const   SizedBox(height: 15,),
                const Text('Update details',style: TextStyle(
                    color: Colors.deepOrange,
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                  ),
                  ),
                    const SizedBox(height: 20,),
                  TextFormField(
                  controller: _nameformController,
                     decoration: const InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(
                          color: Colors.grey
                          ),
                          border: OutlineInputBorder(),
                    ),
                      validator:(value){
                      if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value!) || 
                          value.length < 3 ||
                          value.isEmpty){
                         return 'please enter a valid username';
                      }else{
                         return null;
                      }
                    }
                   ),
                const SizedBox(height: 5,),
                  TextFormField(
                controller:_ageformController,
                    decoration: const InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(
                          color: Colors.grey
                          ),
                          border: OutlineInputBorder(),
                    ),
                          validator:(value){
                      if (RegExp(r'^[0-9][)]+$').hasMatch(value!) || 
                          value.length > 3 ||
                          value.isEmpty){
                         return 'please enter a valid age';
                      }else{
                         return null;
                      }
                    }
                   ),
                   const SizedBox(height: 5,),
                  TextFormField(
                  controller:_stndformController,
                    decoration: const InputDecoration(
                          hintText: "Class",
                          hintStyle: TextStyle(
                          color: Colors.grey
                          ),
                          border: OutlineInputBorder(),
                    ),
                           validator:(value){
                      if (!RegExp(r'^[0-9][){0-2}]+$').hasMatch(value!) ||
                      value.isEmpty){
                         return 'please enter a valid class';
                      }else{
                         return null;
                      }
                    }
                   ),
                 const SizedBox(height: 5,),
                TextFormField(
                   controller:_regformController,
                    decoration: const InputDecoration(
                          hintText: "Register no.",
                          hintStyle: TextStyle(
                          color: Colors.grey
                          ),
                          border: OutlineInputBorder(),
                    ),
                         validator:(value){
                  if (!RegExp(r'^[0-9][){0-5}]+$').hasMatch(value!) ||
                  value.isEmpty){
                         return 'please enter a valid register no.';
                      }else{
                         return null;
                      }
                    }
                   ),
                const SizedBox(height: 5,),
                  ElevatedButton.icon(onPressed: (){
                    if (formkey.currentState!.validate() ){
                      setState(() {
                           update(context);
                      }); 
                    }
                  },
                   icon:  const Icon(Icons.add_circle_outline), 
                   label: const Text('SAVE'),
                             ),
                        //TextFieldl
                 
                  ]),
              ),
            ),
          ),
        ),
        );

   } 

  update(BuildContext context) {
    final String name = _nameformController.text;
    final String age = _ageformController.text;
    final String stdn = _stndformController.text;
    final String reg = _regformController.text;

    if (name.isEmpty || age.isEmpty || stdn.isEmpty || reg.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please Enter Valid Data'),
      ));

    } else {

   // ignore: prefer_if_null_operators
   final student = StudentModel(name: name, age: age,reg: reg,stnd: stdn,img: img==null ? imag:img,id: widget.studentModel.id);
   setState(() {
      updateStudent(student);
   });
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 72, 202, 77),
        content: Text('Data Updated SuccessFully'),
      ));
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenHome()), (route) => false);
     }
      pickImageGallery() async{
   final XFile? image =await _imagePicker.pickImage(source: ImageSource.gallery);
      if(image != null){
         setState(() {
            imageSelect = File(image.path);
         final bytes =  File(image.path).readAsBytesSync();
         setState(() {
            img = base64.encode(bytes);
         });
           
  }
  );
 }
}
}