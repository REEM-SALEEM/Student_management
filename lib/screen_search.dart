import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_record/functions/db_functions.dart';
import 'package:students_record/screen_ontap.dart';


class ScreenSearch extends StatelessWidget {
   ScreenSearch({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter student name to search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                  controller: searchController,
                  onChanged: (value){
                        getSearchResult(value);
                     },
                    ),
                  ),
                ),
              ],
            ),
Obx(
  (){
    return Expanded(
      child:ListView.separated(itemBuilder: (context, index) {
        var data = searchData[index];
    if (data.name.toLowerCase()
                            .contains(searchController.text.toLowerCase())){
         return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Card(
            color:const Color.fromARGB(168, 186, 204, 156) ,
           child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenOntap(studentModel: data)));
                                },
                                title: Text(
                                  data.name.toUpperCase(),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: searchData.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}