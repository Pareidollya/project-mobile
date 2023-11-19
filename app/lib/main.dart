import 'package:app/firebase_options.dart';
import 'package:app/providers/tasks_provider.dart';
import 'package:app/providers/user_provider.dart';// Importe seu novo provider
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/register.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()), // Seu novo provider
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
