import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_record/functions/db_functions.dart';
import 'package:students_record/model/data_model.dart';
import 'package:students_record/screen_home.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
 
  File? imageSelect;
  dynamic img;
 
  final _imagePicker = ImagePicker();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _stndController = TextEditingController();
  final _regController = TextEditingController();


  final _formkey = GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
 

    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title:const Text('Profile Data',),
        ),

        body: Padding(
          padding:const EdgeInsets.all(25),
          
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

   //imageselect(ternary operation)
                children: [
                  imageSelect == null ?
                  AspectRatio(
                    aspectRatio: 2,
                   child: Container(
                          decoration:
                          const BoxDecoration(
                             image: DecorationImage(
                               image: AssetImage('assets/images/user.png')
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
                    child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                      child: ClipOval(
                          child: 
                        Image.file(
                          File(imageSelect!.path), 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            //Text                
                   const SizedBox(height: 15,),
                  const Text('Enter The Data',style: 
                    TextStyle(
                       color: Colors.deepOrange,
                       fontSize: 24,
                       fontWeight: FontWeight.bold,
                    ),
                  ),
    //TextField name
                   const SizedBox(height: 20,),
                  TextFormField(
                    controller: _nameController,
                        decoration: 
                        const InputDecoration(
                                hintText: "Student Name",
                                hintStyle:
                              TextStyle(
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
                        
    //TextField age
                    const SizedBox(height: 5,),
                  TextFormField(
                    controller: _ageController,
                        decoration:
                        const InputDecoration(
                                hintText: "Age",
                                hintStyle: 
                              TextStyle(
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
    //TextField class
                   const SizedBox(height: 5,),
                  TextFormField(
                  controller: _stndController,
                        decoration:
                        const InputDecoration(
                               hintText: "Class",
                                hintStyle:
                              TextStyle(
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
    //TextField reg               
                 const SizedBox(height: 5,),
                    TextFormField(
                      controller:_regController ,
                        decoration:
                        const InputDecoration(
                                hintText: "Register no.",
                                hintStyle:
                              TextStyle(
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
    // elevated button
                    const SizedBox(height: 5,),
                      ElevatedButton.icon(onPressed: (){
                        if (_formkey.currentState!.validate()){
                           onAddStudentButtonClicked();
                        }
                      
                      },
                         icon:  const Icon(Icons.add_circle_outline), 
                         label: const Text('ADD'),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  

  pickImageGallery() async{
   final XFile? image =await _imagePicker.pickImage(source: ImageSource.gallery);
 
      if (image !=null){
         setState(() {
             imageSelect = File(image.path);
         final bytes =  File(image.path).readAsBytesSync();
        
       img=base64.encode(bytes);
  });
  }
}

 Future<void> onAddStudentButtonClicked() async{

  final String name = _nameController.text.trim();
  final String age = _ageController.text.trim();
  final dynamic reg=_regController.text.trim();
  final dynamic stdn=_stndController.text.trim();

  if(name.isEmpty || age.isEmpty ||reg.isEmpty||stdn.isEmpty){
    return;
  }
  
  final student = StudentModel(
    name: name,
     age: age,
     reg: reg,
     stnd: stdn,
     img:img,
     );
  
 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 72, 202, 77),
        content: Text('Data Entered SuccessFully'),
      ));
  setState(() {
     addStudent(student);
  
  });
  setState(() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:  (ctx) =>const ScreenHome()), (route) => false);
  });
}






















}

