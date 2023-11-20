import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app/model/task.dart';
import 'package:app/providers/tasks_provider.dart';

class CreateTask extends StatefulWidget {
  final String userId;

  CreateTask({Key? key, required this.userId}) : super(key: key);

  static void show(BuildContext context, String userId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => CreateTask(userId: userId),
    );
  }

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      _selectTime(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitTask() {
    if (_selectedDate != null && _selectedTime != null && _titleController.text.isNotEmpty) {
      final DateTime finalDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      Task newTask = Task(
        id: DateTime.now().toString(),
        title: _titleController.text,
        date: DateFormat('dd/MM/yyyy HH:mm').format(finalDateTime),
        status: 'Pending',
        completed: false,
        userId: widget.userId,
      );

      Provider.of<TaskProvider>(context, listen: false).createTask(newTask);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                suffixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                _selectedDate == null
                    ? 'Selecione uma data'
                    : DateFormat('dd/MM/yyyy').format(_selectedDate!),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text(
                _selectedTime == null
                    ? 'Selecione um horário'
                    : _selectedTime!.format(context),
              ),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Criar Tarefa'),
              onPressed: _submitTask,
            ),
          ],
        ),
      ),
    );
  }
}
