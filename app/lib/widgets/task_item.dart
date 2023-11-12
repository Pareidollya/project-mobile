import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final String deadline;
  final String status;
  final String completed;
  // final VoidCallback onStatusChanged;
  final VoidCallback onMenuPressed;

  const TaskItem({
    Key? key,
    required this.id,
    required this.title,
    required this.deadline,
    required this.status,
    // required this.onStatusChanged,
    required this.completed,
    required this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, bottom: 10),
      child: Card(
        color: Colors.grey[850], // Define a cor do fundo do card
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Theme(
              data: ThemeData(
                  unselectedWidgetColor:
                      Colors.white), // Cor quando não selecionado
              child: Checkbox(
                value: status == '2',
                onChanged: (bool? newValue) {
                  print('a');
                },
                activeColor: Colors.white, // Cor do Checkbox quando ativado
                checkColor: Colors.black, // Cor da marca de seleção
                shape: const CircleBorder(),
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white, // Define a cor do texto
                fontWeight: FontWeight.bold, // Define a espessura do texto
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(
                  top:
                      8.0), // Aumenta o espaçamento entre o título e o subtítulo
              child: Text(
                //TODO: ajustar por status
                'Fazer até: $deadline',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.7), // Texto um pouco mais claro
                ),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.more_vert, // Ícone com as 3 bolinhas
                color: Colors.white, // Cor do ícone
              ),
              onPressed: onMenuPressed,
            ),
          ),
        ),
      ),
    );
  }
}
