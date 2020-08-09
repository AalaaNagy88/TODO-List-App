import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _taskController=TextEditingController();
  TextEditingController _detialsController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Todos",
          style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context){
              return ["All","Completed","Incompeleted"].map((option){
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          )
        ],
      ),
        backgroundColor: Colors.deepPurple,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top:0,
              child: Container(
                width: 400,
                height: 500,
                child: Image.asset(
                  'assests/image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            DraggableScrollableSheet(
                maxChildSize: 0.85,
                builder:
                    (BuildContext context, ScrollController scrolController) {
                  return Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                        ),
                        child: ListView.builder(
                          controller: scrolController,
                            itemCount: 15,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text("Task NO $i",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text("the detials of task no $i",style: TextStyle(color: Colors.grey[700]),),
                                trailing: IconButton(icon: Icon(Icons.check_circle,color: Colors.greenAccent,), onPressed: (){}),
                                isThreeLine: true,
                              );
                            })
                      ),
                      Positioned(
                        top:-30,
                        right:30,
                        child: FloatingActionButton(onPressed: (){
                          showDialog(context: context,child: Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 10,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _taskController,
                                      ),
                                      TextFormField(
                                        controller: _detialsController,
                                      ),
                                      FlatButton(
                                        child: Text("Add",style: TextStyle(color: Colors.deepPurple),),
                                      )
                                    ],
                              ),
                                ),
                          ));

                        },child: Icon(Icons.add,color: Colors.white,),
                        backgroundColor: Colors.pinkAccent,),
                      )
                    ],
                  );
                })
          ],
        ));
  }
}
