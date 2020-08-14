import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todolistapp/models/todo_model.dart';

class TodoHelper{
  Database db;
  final tableName="Todos";
  final id="id";
  final name="name";
  final details="details";
  final date="date";
  final time="time";
  final done="done";
  Future<Database> initDatabase()async{
   try{
     String path=join(await getDatabasesPath(),"my_list_todo.db");
     db=await openDatabase(path,version: 1,onCreate: (t,version){
       t.execute("CREATE TABLE $tableName($id INTEGER PRIMARY KEY,$name TEXT,$details TEXT,$date TEXT,$time TEXT,$done INTEGER)");
       return db;
     });
   }catch(e){
     print(e.toString());
   }
   return null;

  }

  Future<void> insertData(TodoModel todo)async{
    try{
      await db.insert(tableName, todo.toMap());
    }catch(e){
      print(e.toString());
    }
  }
  Future<List<TodoModel>> getAllTodos()async{
    final allTodos=await db.query(tableName);
    return List.generate(allTodos.length, (index){
      return TodoModel.fromMap(allTodos[index]);
    });
  }
  Future<void>deleteTodo(int id)async{
    await db.delete(tableName,where:"$id=?",whereArgs: [id]);
  }
  Future<void>updateTodo(TodoModel todo)async{
    await db.update(tableName,todo.toMap(),where: "$id=?",whereArgs: [todo.id]);
  }
}