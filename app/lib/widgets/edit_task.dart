import 'package:app/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app/model/task.dart';

class EditTask extends StatefulWidget {
  final Task task;

  EditTask({Key? key, required this.task}) : super(key: key);

  static void show(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) => EditTask(task: task),
    );
  }

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _selectedDate = DateFormat('dd/MM/yyyy').parse(widget.task.date);
    _selectedTime = TimeOfDay(
      hour: int.parse(widget.task.date.split(' ')[1].split(':')[0]),
      minute: int.parse(widget.task.date.split(' ')[1].split(':')[1]),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _updateTask() {
    final DateTime finalDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    Task updatedTask = widget.task.copyWith(
      title: _titleController.text,
      date: DateFormat('dd/MM/yyyy HH:mm').format(finalDateTime),
    );

    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
    Navigator.of(context).pop();
  }

  void _deleteTask() {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(widget.task.id);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Editar Título da Tarefa'),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              DateFormat('dd/MM/yyyy').format(_selectedDate),
            ),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDate(context),
          ),
          ListTile(
            title: Text(
              _selectedTime.format(context),
            ),
            trailing: Icon(Icons.access_time),
            onTap: () => _selectTime(context),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Atualizar Tarefa'),
            onPressed: _updateTask,
          ),
          ElevatedButton(onPressed: _deleteTask, child: Text('Deletar Tarefa')),
        ],
      ),
    );
  }
}
