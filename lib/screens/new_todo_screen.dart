import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/helper/todo_helper.dart';
import 'package:todolistapp/models/todo_model.dart';

class NewTodoScreen extends StatefulWidget {
  final TodoModel currentTodo;
  NewTodoScreen({Key key, this.currentTodo}) : super(key: key);
  @override
  _NewTodoScreenState createState() => _NewTodoScreenState();
}

class _NewTodoScreenState extends State<NewTodoScreen> {
  bool remindMe = true;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TodoHelper _todoHelper = TodoHelper();
  bool updating;
  Future<void> datePicker(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  Future<void> timePicker(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null && picked != time) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 30),
            child: Text(
              widget.currentTodo == null ? "Create New Todo" : "Edit your todo",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 32, right: 32, left: 32, bottom: 32),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple[200]),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[100]),
                  ),
                  hintText: "Todo Name",
                  hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400])),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 32, left: 32, bottom: 32),
            child: TextField(
              controller: _detailController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple[200]),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[100]),
                  ),
                  hintText: "Todo Detials",
                  hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400])),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: InkWell(
                onTap: () {
                  datePicker(context);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 240, 240, 1),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.redAccent,
                        )),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      DateFormat('E d, MMM  ').format(date).toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[900]),
                    ),
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
              child: InkWell(
                onTap: () {
                  timePicker(context);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 250, 240, 1),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.alarm,
                          color: Colors.orangeAccent,
                        )),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      time.format(context),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[900]),
                    ),
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey[100]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 235, 255, 1),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.alarm_on,
                          color: Colors.purpleAccent[100],
                        )),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      "Remind me",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[900]),
                    ),
                    Spacer(),
                    Switch(
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          remindMe = value;
                        });
                      },
                      value: remindMe,
                    )
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.only(left: 32, right: 32, top: 32),
            width: double.infinity,
            height: 90,
            child: FlatButton(
              onPressed: () {
                TodoModel todo;
                if (updating) {
                 widget.currentTodo.name=_nameController.text;
                 widget.currentTodo.details= _detailController.text;
                 widget.currentTodo.date= DateFormat('E d, MMM  ').format(date).toString();
                widget.currentTodo.time =time.format(context);
                  _todoHelper.updateTodo(widget.currentTodo);
                } else
                  todo = TodoModel(
                      name: _nameController.text,
                      details: _detailController.text,
                      date: DateFormat('E d, MMM  ').format(date).toString(),
                      time: time.format(context),
                      done: 0);
                _todoHelper.insertData(todo);
                updating=false;
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                updating ? "Updating" : "Create Todo",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _todoHelper.initDatabase();
    updating = widget.currentTodo == null ? false : true;
    if (widget.currentTodo != null) {
      _nameController.text = widget.currentTodo.name;
      _detailController.text = widget.currentTodo.details;
    }
  }
}
