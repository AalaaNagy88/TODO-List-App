import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolistapp/helper/todo_helper.dart';
import 'package:todolistapp/models/todo_model.dart';
import 'package:todolistapp/screens/new_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoHelper _todoHelper = TodoHelper();
  List<TodoModel> todos = List<TodoModel>();
  List<TodoModel> completed = List<TodoModel>();
  List<TodoModel> inCompleted = List<TodoModel>();

  Future<Database> db;
  bool done;
  void refreshList() {
    db.then((_) {
      Future<List<TodoModel>> lastTodos = _todoHelper.getAllTodos();
      lastTodos.then((todos) {
        this.todos = todos;
      });
    });
  }

  todoDraggable() {
    return DraggableScrollableSheet(
        maxChildSize: 0.85,
        builder: (BuildContext context, ScrollController scrolController) {
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: todos.length == 0
                      ? Text(
                          "No Todos\n\nclick + to add new",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          controller: scrolController,
                          itemCount: todos.length,
                          itemBuilder: (context, i) {
                            final item = todos[i];
                            item.done == 1 ? done = true : done = false;
                            return Dismissible(
                              direction: DismissDirection.horizontal,
                              background: Container(
                                color: Colors.green,
                                child: Icon(
                                  Icons.mode_edit,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              key: ValueKey(item),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  setState(() {
                                    _todoHelper.deleteTodo(item.id);
                                    todos.removeAt(i);
                                  });
                                }if (direction ==
                                    DismissDirection.startToEnd) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NewTodoScreen(
                                            currentTodo: item,
                                          )));
                                }
                              },
                              child: ListTile(
                                title: Text(item.name,
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  item.details,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                trailing: Column(
                                  children: <Widget>[
                                    Text(item.time,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: Colors.grey[600]),),
                                    Icon(
                                      Icons.check_circle,
                                      color: item.done == 1
                                          ? Colors.greenAccent
                                          : null,
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                                onTap: () {
                                  setState(() {
                                    done = !done;
                                    if (done) {
                                      item.done = 1;
                                    } else
                                      item.done = 0;
                                    _todoHelper.updateTodo(item);
                                  });
                                },
                              ),
                            );
                          }),
                ),
              ),
              Positioned(
                top: -30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewTodoScreen()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.pinkAccent,
                ),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    db = _todoHelper.initDatabase();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    refreshList();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
          title: Text(
            "Todos",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) {
                return ["All", "Completed", "Incompeleted"].map((option) {
                  return PopupMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
              onSelected: (value){
                if(value=="All"){setState(() {
                  refreshList();
                });}
                if(value=="Completed"){
                  completed.clear();
                  todos.forEach((item){
                    if(item.done==1){
                      completed.add(item);
                    }
                    setState(() {
                      todos=completed;
                    });
                  });
                }
                if(value=="Incompeleted"){
                  inCompleted.clear();
                  todos.forEach((item){
                    if(item.done==0){
                      inCompleted.add(item);
                    }
                    setState(() {
                      todos=inCompleted;
                    });
                  });
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.deepPurple,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: 400,
                height: 500,
                child: Image.asset(
                  'assests/image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            todoDraggable(),
          ],
        ));
  }
}
