// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_authn_task/signup.dart';
import 'package:flutter_authn_task/user_controller.dart';

import 'profile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    final controller = AuthController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
          title: Center(child: const Text("Login"))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: BoxBorder.all(color: Colors.grey.shade900)
              ),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(hintText: "Email"),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: Colors.grey.shade900)
              ),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await controller.login(email.text, password.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              ),
              child: const Text("Go to Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
