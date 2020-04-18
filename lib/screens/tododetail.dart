import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;

  TodoDetail(this.todo);

  @override
  _TodoDetailsState createState() => _TodoDetailsState(this.todo);
}

class _TodoDetailsState extends State<TodoDetail> {
  Todo todo;

  _TodoDetailsState(this.todo);

  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle themeTitleStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title,),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            style: themeTitleStyle,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: themeTitleStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          ),
          TextField(
            controller: descriptionController,
            style: themeTitleStyle,
            decoration: InputDecoration(
              labelText: "Description",
              labelStyle: themeTitleStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          ),
          DropdownButton<String>(
            items: _priorities.map((String priority) {
              return DropdownMenuItem<String>(
                value: priority,
                child: Text(priority),
              );
            }).toList(),
            style: themeTitleStyle,
            value: "Low",
            onChanged: null,
          )
        ],
      ),
    );
  }
}
