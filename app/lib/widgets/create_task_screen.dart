import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  final String taskId;

  CreateTaskScreen({Key? key, required this.taskId}) : super(key: key);

  static void show(BuildContext context, String taskId) {
    // se id != '' é criação, senão é edição

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => CreateTaskScreen(
        taskId: taskId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle = taskId == '' ? 'Criar' : 'Editar';
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              '$screenTitle Tarefa $taskId',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            // ...Adicione campos de entrada aqui.
          ],
        ),
      ),
    );
  }
}
