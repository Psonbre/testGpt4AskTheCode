import 'package:flutter/material.dart';
import 'package:revolvair/presentation/views/auth/registration/registration_viewmodel.dart';
import 'package:revolvair/presentation/views/utils/validators.dart';
import 'package:stacked/stacked.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool acceptTerms = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RegistrationViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inscription'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child : Form(
              key: _formKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(viewModel.revolvairLogoUrl),
                TextFormField(
                  controller: viewModel.nameController,
                  validator :(value) => Validators.validateName(viewModel.nameController.text),
                  decoration: const InputDecoration(labelText: 'Nom complet'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.emailController,
                  validator: (value) => Validators.validateEmail(viewModel.emailController.text),
                  decoration: const InputDecoration(labelText: 'Courriel'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.passwordController,
                  validator: (value) => Validators.validatePassword(viewModel.passwordController.text),
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          acceptTerms = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.launchTOS();
                      },
                      child: const Text(
                        "J'accepte les termes et conditions",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async { if (_formKey.currentState!.validate() && acceptTerms) viewModel.registerUser();},
                  child: const Text('Créer le compte'),
                ),
              ],
            ),
            )
          ),
        );
      },
    );
  }
}
