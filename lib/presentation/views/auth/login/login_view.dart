import 'package:flutter/material.dart';
import 'package:revolvair/presentation/views/auth/login/login_viewmodel.dart';
import 'package:revolvair/presentation/views/utils/validators.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Connexion'),
          ),
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(viewModel.logo),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        Validators.validateEmail(_emailController.text),
                    decoration: const InputDecoration(labelText: 'Courriel'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) =>
                        Validators.validatePassword(_passwordController.text),
                    decoration:
                        const InputDecoration(labelText: 'Mot de passe'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.submit(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: const Text('Se connecter'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              viewModel.navigateToRegistrationPage(),
                          child: const Text('Je n\'ai pas de compte'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        )
      )
    );
  }
}
