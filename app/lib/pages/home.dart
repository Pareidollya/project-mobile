import 'package:app/widgets/list_tasks.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int taskCount = 0; // Aqui deve ser a lógica para obter a contagem de tarefas
  List tasks = [
    {
      'id': '1',
      'title': 'Dar a bucetinha gostoso 🥺',
      'deadline': '18/11/2023',
      'status': '1',
      'completed': ''
    },
    {
      'id': '2',
      'title': 'Fazer enema 🥰',
      'deadline': '18/11/2023',
      'status': '2',
      'completed': '18/11/2023 18:45'
    },
    {
      'id': '3',
      'title': 'Dar o cuzinho forte violento assasinato 😈',
      'deadline': '18/11/2023',
      'status': '3',
      'completed': ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    //TODO: isso a deve ser um state
    taskCount = tasks.where((task) => task['status'] == '1').toList().length;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(130.0), // Aumenta a altura da AppBar
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40), // Bordas inferiores arredondadas
            ),
          ),
          backgroundColor: Colors.yellow, // Cor de fundo amarela
          elevation: 0, // Remove a sombra da AppBar
          flexibleSpace: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bem vindo de volta, Hatsune',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Você possui $taskCount tasks',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 50.0, top: 28),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            'https://cdn.discordapp.com/attachments/597261429464367105/1172235696468148314/image.png?ex=655f9491&is=654d1f91&hm=6ce8c88cc378f6a2505d5df94043963d095f29ea9c74244ff7c9614fbe52ed26&'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        ListTasks(
          type: 'To do',
          tasks: tasks.where((task) => task['status'] == '1').toList(),
          handleCreateTask: () {
            print('create task');
          },
        ),
        ListTasks(
          type: 'Concluída',
          tasks: tasks.where((task) => task['status'] == '2').toList(),
          handleCreateTask: () {
            print('create task');
          },
        ),
        ListTasks(
          type: 'Pendente',
          tasks: tasks.where((task) => task['status'] == '3').toList(),
          handleCreateTask: () {
            print('create task');
          },
        ),
      ]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar uma nova tarefa
        },
        child: Icon(Icons.add, color: Colors.black, size: 30),
        backgroundColor: Colors.yellow,
      ),
      // Pode-se adicionar um Drawer ou BottomNavigationBar se necessário
    );
  }
}
