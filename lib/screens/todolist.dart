import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/screens/tododetail.dart';
import 'package:todoapp/util/dbhelper.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
	DbHelper dbHelper = DbHelper();
	List<Todo> todos;
	int count = 0;
	
  @override
  Widget build(BuildContext context) {
  	if(todos == null) {
  		todos = List<Todo>();
  		getData();
	  }
    return Scaffold(
	    body: todoListItems(),
	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		    	navigateToDetail(Todo('', '', 3));
		    },
		    tooltip: "Add new todo",
		    child: Icon(Icons.add),
	    ),
    );
  }
  
  ListView todoListItems() {
    return ListView.builder(
	    itemCount: count,
	    itemBuilder: (BuildContext context, int position) {
	    	return Card(
			    color: Colors.white,
			    elevation: 2.0,
			    child: ListTile(
				    title: Text(todos[position].title),
				    subtitle: Text(todos[position].date),
				    leading: CircleAvatar(
					    backgroundColor: getColor(todos[position].priority),
					    child: Text(todos[position].priority.toString()),
				    ),
				    onTap: () {
				    	debugPrint("Tapped on: " + todos[position].id.toString());
				    	navigateToDetail(todos[position]);
				    },
			    ),
		    );
	    }
    );
  }

  void getData() {
  	final dbFuture = dbHelper.initializeDb();
  	dbFuture.then((db) {
		  final todosFuture = dbHelper.getTodos();
		  todosFuture.then((result) {
		    List<Todo> todoList = List<Todo>();
		    int length = result.length;
		    for(int i = 0; i < length; i++) {
		    	todoList.add(Todo.fromObject(result[i]));
		    	debugPrint(todoList[i].title);
		    }
		    
		    setState(() {
		      todos = todoList;
		      count = length;
		    });
		  });
	  });
  }

  Color getColor(int priority) {
  	switch (priority) {
		  case 1: return Colors.red;
		  case 2: return Colors.orange;
		  case 3: return Colors.green;
		  
		  default: return Colors.green;
	  }
  }
  
  void navigateToDetail(Todo todo) async{
  	bool result = await Navigator.push(
		  context,
		  MaterialPageRoute(builder: (context) => TodoDetail(todo)),
	  );
  	
  	if(result == true) {
  		getData();
	  }
  }
}
