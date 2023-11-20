import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/model/user.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/services/user_service.dart';
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenSize.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Just do It",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tourney',
                          fontSize: 60
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.08),
                  Align(
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
                  SizedBox(height: screenSize.height * 0.03),
                  InputLarge(labelText: "Usuário", controller: _userController),
                  SizedBox(height: screenSize.height * 0.02),
                  InputLarge(
                    labelText: "Senha",
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.3, vertical: 20),
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
                  SizedBox(height: screenSize.height * 0.04),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: RichText(
                      text: TextSpan(
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
          ),
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
