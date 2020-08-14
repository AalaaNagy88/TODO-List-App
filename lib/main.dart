import 'package:flutter/material.dart';
import 'package:todolistapp/screens/todo_screen.dart';


void main(){
  WidgetsFlutterBinding();
  runApp(
    MaterialApp(
      title: "List TODO app",
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurple,
        primaryColorLight: Colors.deepPurple
      ),
      debugShowCheckedModeBanner: false,
      home:TodoScreen(),
    )
    );}

