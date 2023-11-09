import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int taskCount = 0; // Aqui deve ser a lógica para obter a contagem de tarefas
  bool _isList1Visible = true;
  bool _isList2Visible = false;
  bool _isList3Visible = false;

  void _toggleList1() {
    setState(() {
      _isList1Visible = !_isList1Visible;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        // Insira a imagem do usuário aqui
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
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
                    primary: Colors.white, // Cor do texto e do ícone
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Bordas arredondadas
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0), // Espaçamento interno
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Do It',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const Spacer(), // Isso empurrará o texto e o ícone para lados opostos
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
            child: Column(children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 23, right: 23, bottom: 10),
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
                            value:
                                false, // Aqui você pode vincular o valor do Checkbox
                            onChanged: (bool? newValue) {
                              // Adicione a lógica para lidar com a mudança de estado do checkbox
                            },
                            activeColor:
                                Colors.white, // Cor do Checkbox quando ativado
                            checkColor: Colors.black, // Cor da marca de seleção
                            shape: const CircleBorder(),
                          ),
                        ),
                        title: const Text(
                          'Do Math Homework',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Define a cor do texto
                            fontWeight:
                                FontWeight.bold, // Define a espessura do texto
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                              top:
                                  8.0), // Aumenta o espaçamento entre o título e o subtítulo
                          child: Text(
                            'Fazer até: 18/11/2023',
                            style: TextStyle(
                              color: Colors.white.withOpacity(
                                  0.7), // Texto um pouco mais claro
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.more_vert, // Ícone com as 3 bolinhas
                            color: Colors.white, // Cor do ícone
                          ),
                          onPressed: () {
                            // Adicione a lógica para o que deve acontecer quando o ícone é pressionado
                          },
                        ),
                      ),
                    ),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 23, right: 23, bottom: 10),
                  child: Card(
                    color: Colors.grey[850], // Define a cor do fundo do card
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Color.fromARGB(255, 28,
                                  214, 21)), // Cor quando não selecionado
                          child: Checkbox(
                            value:
                                true, // Aqui você pode vincular o valor do Checkbox
                            onChanged: (bool? newValue) {
                              // Adicione a lógica para lidar com a mudança de estado do checkbox
                            },
                            activeColor: const Color.fromARGB(255, 255, 255,
                                255), // Cor do Checkbox quando ativado
                            checkColor: Colors.black, // Cor da marca de seleção
                            shape: const CircleBorder(),
                          ),
                        ),
                        title: const Text(
                          'Dar bct',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Define a cor do texto
                            fontWeight:
                                FontWeight.bold, // Define a espessura do texto
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                              top:
                                  8.0), // Aumenta o espaçamento entre o título e o subtítulo
                          child: Text(
                            'Fazer até: Agora!',
                            style: TextStyle(
                              color: Colors.white.withOpacity(
                                  0.7), // Texto um pouco mais claro
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.more_vert, // Ícone com as 3 bolinhas
                            color: Colors.white, // Cor do ícone
                          ),
                          onPressed: () {
                            // Adicione a lógica para o que deve acontecer quando o ícone é pressionado
                          },
                        ),
                      ),
                    ),
                  ))
            ]),
          ),
          // Repita o padrão acima para os botões "Pending" e "Completed"
        ],
      ),
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
