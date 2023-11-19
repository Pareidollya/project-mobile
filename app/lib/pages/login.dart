import 'package:app/model/user.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/widgets/input_large.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    final userService = UserService();
    try {
      User user = await userService.login(
        _userController.text,
        _passwordController.text,
      );
      print("Usuário logado com sucesso");
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      Navigator.pushNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos, tente novamente!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Just do It",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tourney',
              ),
            ),
            const SizedBox(height: 100),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            InputLarge(labelText: "Usuário", controller: _userController),
            const SizedBox(height: 20),
            InputLarge(
              labelText: "Senha",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text(
                "Entrar",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Não possui cadastro? ',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Registre-se',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
