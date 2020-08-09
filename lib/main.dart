import 'package:flutter/material.dart';
import 'package:todolistapp/todo_screen.dart';

void main()=>runApp(
    MaterialApp(
      title: "List TODO app",
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    )
    );

