import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/todo.dart';

class DbHelper {
	static final DbHelper _dbHelper = DbHelper._internal();
	
	String tblTodo = "todo";
	String colId = "id";
	String colTitle = "title";
	String colDescription = "description";
	String colDate = "date";
	String colPriority = "priority";
	
	DbHelper._internal();
	
	factory() {
		return _dbHelper;
	}
	
	static Database _db;
	
	Future<Database> get db async {
		if(_db == null) _db = await initializeDb();
		return _db;
	}
	
	Future<Database> initializeDb() async {
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + "todos.db";
		var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
		return dbTodos;
	}

  Future<FutureOr<void>> _createDb(Database db, int version) async {
		await db.execute(
			"CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
			"$colDescription Text, $colPriority INTEGER, $colDate TEXT)"
		);
  }
  
  Future<int> insertTodo(Todo todo) async {
		Database db = await this.db;
		var result = await db.insert(tblTodo, todo.toMap());
		return result;
  }
  
  Future<List> getTodos() async {
		Database db = await this.db;
		var result = await db.rawQuery("Select * from $tblTodo order by $colPriority ASC");
		return result;
  }
  
  Future<int> getCount() async {
	  Database db = await this.db;
	  var result = Sqflite.firstIntValue(
		  await db.rawQuery("Select count (*) from $tblTodo")
	  );
	  return result;
  }
  
  Future<int> updateTodo(Todo todo) async {
		Database db = await this.db;
		var result = db.update(tblTodo, todo.toMap(), where: "$colId = ?", whereArgs: [todo.id]);
		return result;
  }
  
  Future<int> deleteTodo(int id) async {
		var db = await this.db;
		int result = await db.rawDelete("DELETE from table $tblTodo where $colId = $id");
		return result;
  }
}