import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            auth.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      // Capture context synchronously before async gap
                      final currentContext = context;
                      final messenger = ScaffoldMessenger.of(currentContext);

                      final result = await auth.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      // For messenger - already safe from earlier capture
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            result.success
                                ? "Login successful"
                                : result.error ?? "Login failed",
                          ),
                        ),
                      );

                      // For navigation - use mounted check with locally captured context
                      if (result.success && mounted && currentContext.mounted) {
                        Navigator.of(currentContext).pushReplacement(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignupScreen()),
              ),
              child: const Text("No account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
