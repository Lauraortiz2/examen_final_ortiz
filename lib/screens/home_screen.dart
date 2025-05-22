import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Examen final')),
      body: SingleChildScrollView(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'logout',
        child: const Icon(Icons.exit_to_app),
        onPressed: () {
          LoginForm.signOut();
          Navigator.of(context).pushNamed('login');
        },
      ),
    );
  }
}
