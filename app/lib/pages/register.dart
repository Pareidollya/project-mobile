import 'package:flutter/material.dart';
import 'package:app/widgets/input_large.dart';
import 'package:app/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _selectedAvatar = 'avatar_1';

  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não coincidem!')),
      );
      return;
    }

    try {
      print("chamando o UserService");

      if (await UserService().getUserByUsername(_usernameController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário já cadastrado!')),
        );
        return;
      }

      await UserService().createUser(
        _usernameController.text,
        _passwordController.text,
        _selectedAvatar,
      );


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );

      Navigator.of(context).pop();
      _usernameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }

  Widget _buildAvatar(String avatarName) {
    bool isSelected = _selectedAvatar == avatarName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatar = avatarName;
        });
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/$avatarName.png'),
        radius: 30,
        child: isSelected
            ? Icon(Icons.check_circle, color: Colors.yellow, size: 60)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Let's do It",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tourney',
                ),
              ),
              const SizedBox(height: 60),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cadastro",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InputLarge(
                  labelText: "Username ( login )",
                  controller: _usernameController),
              const SizedBox(height: 20),
              InputLarge(
                  labelText: "Password",
                  obscureText: true,
                  controller: _passwordController),
              const SizedBox(height: 20),
              InputLarge(
                  labelText: "Confirm Password",
                  obscureText: true,
                  controller: _confirmPasswordController),
              const SizedBox(height: 30),
              const Text(
                "Selecione um avatar",
                style: TextStyle(color: Colors.yellow, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: List.generate(
                    6, (index) => _buildAvatar('avatar_${index + 1}')),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  onPrimary: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
