import 'package:flutter/material.dart';
import 'package:app/model/task.dart'; // Certifique-se de que o caminho para o modelo Task está correto
import 'package:app/widgets/edit_task.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart'; // Certifique-se de que o caminho para EditTask está correto

class ListTasks extends StatefulWidget {
  final String type;
  final List<Task> tasks;

  ListTasks({
    Key? key,
    required this.type,
    required this.tasks,
  }) : super(key: key);

  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 107, 107, 107),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: ListTile(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            title: Text(
              '${widget.type}   (${widget.tasks.length})',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
        ),
        Visibility(
          visible: _isExpanded,
          child: Column(
            children: widget.tasks.map((task) {
              return Card(
                color: Color.fromARGB(255, 36, 36, 36),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () => {
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(
                      task.copyWith(
                        completed: !task.completed,
                      ),
                    ),
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor:
                        task.status == 'completed' || task.completed
                            ? Colors.green
                            : task.status == 'pending'
                                ? Colors.orange[900]
                                : Colors.blue[50],
                    child: task.status == 'completed'
                        ? Icon(Icons.check, color: Colors.white)
                        : task.status == 'pending'
                            ? Icon(Icons.error_outline, color: Colors.white)
                            : Icon(Icons.access_time, color: Colors.white),
                  ),
                  title:
                      Text(task.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text('${task.date}',
                      style: TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      EditTask.show(context, task);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
