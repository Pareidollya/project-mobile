// list_tasks.dart
import 'package:flutter/material.dart';
import 'task_item.dart'; // Assegure-se de que o caminho para item.dart está correto

class ListTasks extends StatefulWidget {
  final String type;
  final List tasks;
  final VoidCallback handleCreateTask;

  ListTasks(
      {Key? key,
      required this.tasks,
      required this.handleCreateTask,
      required this.type})
      : super(key: key);

  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  bool _isList1Visible = true;
  void _toggleList1() {
    setState(() {
      _isList1Visible = !_isList1Visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, bottom: 10),
            child: Container(
              width: 150,
              child: TextButton(
                onPressed: _toggleList1,
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 107, 107, 107),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16.0),
                ),
                child: Row(
                  children: [
                    Text('${widget.type}',
                        style: const TextStyle(fontSize: 18)),
                    const Spacer(),
                    Icon(
                      _isList1Visible
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isList1Visible,
          child: Column(
            children: widget.tasks.map((task) {
              return TaskItem(
                id: task['id'],
                title: task['title'],
                deadline: task['deadline'],
                status: task['status'],
                completed: task['completed'],
                onMenuPressed: () {
                  // Implementar lógica para quando o menu for pressionado
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
