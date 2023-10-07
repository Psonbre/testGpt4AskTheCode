import 'package:flutter/material.dart';
import 'package:revolvair/presentation/views/home/home_viewmodel.dart';

class DrawerWidget extends StatelessWidget {
  final HomeViewModel _viewModel;

  const DrawerWidget({required HomeViewModel homeViewModel, Key? key})
      : _viewModel = homeViewModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Revolvair'),
          ),
          ListTile(
            title: const Text('Échelles de qualité de l\'air'),
            onTap: () {
              Navigator.pop(context);
              _viewModel.navigateToScaleViewPage();
            },
          ),
          ListTile(
            title: const Text('Se connecter'),
            onTap: () {
              Navigator.pop(context);
              _viewModel.navigateToLoginPage();
            },
          ),
        ],
      ),
    );
  }
}
