import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:students_record/model/data_model.dart';
import 'package:students_record/screen_home.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
      primarySwatch: Colors.deepOrange
      ),
      debugShowCheckedModeBanner: false, //remove debug banner
      home: const ScreenHome(),
      );
  }
}