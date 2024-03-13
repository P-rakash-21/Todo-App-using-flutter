import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = [];

  TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
    taskController.clear();
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      // Example of toggling completion by crossing out the task
      tasks[index] = tasks[index].startsWith('✓ ')
          ? tasks[index].substring(2)
          : '✓ ${tasks[index]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              labelText: 'Enter Task',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (taskController.text.isNotEmpty) {
                    addTask(taskController.text);
                  }
                },
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                addTask(value);
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    tasks[index],
                    style: TextStyle(
                      decoration: tasks[index].startsWith('✓ ')
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          toggleTaskCompletion(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
