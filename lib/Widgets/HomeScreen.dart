import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/Widgets/TaskList.dart';

import '../class/Todo.dart';



class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override

  Widget build(BuildContext context){
    final todo= Provider.of<Todo>(context);
    return  Scaffold(
        appBar: AppBar(
          title:  Center(
            child: Text("Todo list With flutter provider",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20
              ),
            ),
          ),
          backgroundColor: Colors.black87,
        ),
        body: const Column(
          children: [
            SizedBox(height: 20,),
            Center(
                child: Text(
                  'The tasks list',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
            ),
            SizedBox(height: 7,),
            TaskList()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await addTodoWidget();
          },
          child: const Icon(Icons.add),
        )
    );
  }

  Future<void> addTodoWidget() async{
    await showDialog(
        context: context,
        builder: (context){
          final key=GlobalKey<FormState>();
          final todo=Provider.of<Todo>(context);
          final addTaskEditing=TextEditingController();
          return   AlertDialog(
            title: const Center(
              child:  Text("Add a new taks"),
          ),
            actions: [
              SizedBox(
                width: 300,
                child: Form(
                  key: key,
                  child: Column(
                      children: [
                        TextFormField(
                          controller: addTaskEditing,
                          decoration: const InputDecoration(
                              hintText: "Enter your task",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.blue
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.orange
                                ),
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty || value==''){
                              return "Veuillez correctement remplir le champ";
                            }
                          },
                        ),
                        const SizedBox(height: 30,),
                        MaterialButton(
                          onPressed: (){
                            if(key.currentState!.validate()){
                              key.currentState!.save();
                              setState((){
                                todo.addTask(addTaskEditing.text);
                              });
                              addTaskEditing.clear();
                            }
                          },
                          minWidth: 300,
                          height: 45,
                          color:Colors.orange[500],
                          padding: const EdgeInsets.all(5),
                          elevation: 7,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: const Text(
                            "Add task",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ]
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}