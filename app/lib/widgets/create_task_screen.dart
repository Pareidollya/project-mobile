import 'package:app/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/model/task.dart';

class CreateTaskScreen extends StatefulWidget {
  final String taskId;

  CreateTaskScreen({Key? key, required this.taskId}) : super(key: key);

  static void show(BuildContext context, String taskId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => CreateTaskScreen(taskId: taskId),
    );
  }

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  void _submitTask(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final newTask = Task(
      id: widget.taskId.isEmpty ? DateTime.now().toString() : widget.taskId,
      title: _titleController.text,
      date: _deadlineController.text,
      status: '1',
      completed: false,
      userId: 'user-id', // Substitua pelo id do usuário correto
    );

    if (widget.taskId.isEmpty) {
      taskProvider.createTask(newTask);
    } else {
      taskProvider.updateTask(newTask);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle = widget.taskId.isEmpty ? 'Criar' : 'Editar';

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
            // Cabeçalho
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
              '$screenTitle Tarefa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            // Campos de Entrada
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título da Tarefa'),
            ),
            TextField(
              controller: _deadlineController,
              decoration: InputDecoration(labelText: 'Prazo (ex: 20/04/2023)'),
            ),
            // Botão de Submissão
            ElevatedButton(
              child: Text('Salvar Tarefa'),
              onPressed: () => _submitTask(context),
            ),
          ],
        ),
      ),
    );
  }
}
