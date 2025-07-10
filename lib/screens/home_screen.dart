import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'notes_screen.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginScreen();
    }

    return ChangeNotifierProvider(
      create: (_) => NotesProvider(user.uid),
      child: const NotesScreen(),
    );
  }
}
