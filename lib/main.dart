import 'package:flutter/material.dart';
import 'package:todoapp/screens/todolist.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: "Todos",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: Home(title: "Todos"),
    );
  }
}

class Home extends StatefulWidget {
  final String title;
  
  Home({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TodoList(),
    );
  }
  
}


