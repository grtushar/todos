import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/util/dbhelper.dart';

DbHelper dbHelper = DbHelper();
final List<String> choices = const <String>[
  "Save Todo & Back",
  "Delete Todo",
  "Back to List"
];

const menuSave = "Save Todo & Back";
const menuDelete = "Delete Todo";
const menuBack = "Back to List";

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
          automaticallyImplyLeading: false, // hide the back button
          title: Text(
            todo.title,
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: titleController,
                    style: themeTitleStyle,
                    onChanged: (value) => updateTitle(),
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: themeTitleStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: descriptionController,
                    style: themeTitleStyle,
                    onChanged: (value) => updateDescription(),
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: themeTitleStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
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
                  value: retrievePriority(todo.priority),
                  onChanged: (value) => updatePriority(value),
                )
              ],
            ),
          ],
        ));
  }

  void select(String value) async {
    int result;
    switch (value) {
      case menuSave:
        save();
        break;
      case menuDelete:
        Navigator.pop(context, true);
        if (todo.id != null) {
          result = await dbHelper.deleteTodo(todo.id);
          if (result != 0) {
            AlertDialog alertDialog = AlertDialog(
              title: Text("Delete Todo"),
              content: Text("The todo has been deleted"),
            );

            showDialog(
              context: context,
              builder: (_) => alertDialog,
            );
          }
        }
        break;
      case menuBack:
        Navigator.pop(context, true);
        break;
    }
  }

  void save() {
    todo.date = DateFormat.yMd().format(DateTime.now());
    if (todo.id != null)
      dbHelper.updateTodo(todo);
    else
      dbHelper.insertTodo(todo);

    Navigator.pop(context, true);
  }

  void updatePriority(String value) {
    switch (value) {
      case "High":
        todo.priority = 1;
        break;
      case "Medium":
        todo.priority = 2;
        break;
      case "Low":
        todo.priority = 3;
        break;
    }

    setState(() {
      _priority = value;
    });
  }

  String retrievePriority(int value) {
    return _priorities[value - 1];
//    switch(value) {
//      case 1:
//        return "High";
//        break;
//      case 2:
//        return "Medium";
//        break;
//      case 3:
//        return "Low";
//        break;
//
//      default:
//        return "Low";
//    }
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() => todo.description = descriptionController.text;
}
