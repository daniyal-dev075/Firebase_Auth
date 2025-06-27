// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_authn_task/user_controller.dart';
import 'package:flutter_authn_task/user_model.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  final controller = AuthController();

  @override
  void initState() {
    super.initState();

    controller
        .getUserData()
        .then((value) {
          setState(() => user = value);
        })
        .catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text("Profile"))),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Name:  ${user!.name}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  Center(
                    child: Text(
                      "    Email: ${user!.email}",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
