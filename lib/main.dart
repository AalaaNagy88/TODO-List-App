import 'package:flutter/material.dart';
import 'package:todolistapp/screens/todo_screen.dart';


void main(){
  Future.delayed(Duration(milliseconds: 3000),(){});
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

