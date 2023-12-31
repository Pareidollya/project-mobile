import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/providers/tasks_provider.dart';
import 'package:app/widgets/task_list.dart';
import 'package:app/widgets/create_task.dart';
import '../functions/task_status.dart';
import '../model/task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<UserProvider>(context, listen: false).user.id;
      Provider.of<TaskProvider>(context, listen: false).getTasks(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final tasks = Provider.of<TaskProvider>(context).tasks.map((task) {
      return Task(
        id: task.id,
        title: task.title,
        date: task.date,
        status: determineTaskStatus(task.date, task.completed),
        completed: task.completed,
        userId: task.userId,
      );
    }).toList();
    final lengthTask = tasks.where((task) => !task.completed).length;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
          backgroundColor: Colors.yellow,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Bem vindo de volta, ${user.username}!',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Você possui $lengthTask tasks',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0, top: 28),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('assets/images/${user.avatarIcon}.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTasks(type: "Todo", tasks: tasks.where((task) => task.status == 'doing').toList()),
            ListTasks(type: "Pending", tasks: tasks.where((task) => task.status == 'pending').toList()),
            ListTasks(type: "Done", tasks: tasks.where((task) => task.status == 'completed').toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CreateTask.show(context, user.id),
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
