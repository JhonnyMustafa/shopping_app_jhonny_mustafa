import 'package:shopping_app_jhonny_mustafa/helpers/validator.dart';
import 'package:shopping_app_jhonny_mustafa/models/user_login.dart';
import 'package:shopping_app_jhonny_mustafa/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserLogin userLogin = UserLogin(
    name: '',
    email: '',
    password: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (newValue) => userLogin.name = newValue!,
                  validator: Validation.validateName,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (newValue) => userLogin.email = newValue!,
                  validator: Validation.validateEmail,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  onSaved: (newValue) => userLogin.password = newValue!,
                  validator: Validation.validatePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(user: userLogin)),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
