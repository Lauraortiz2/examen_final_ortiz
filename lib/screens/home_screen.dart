import 'package:examen_final_ortiz/widgets/personajes_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final frozenProvider = Provider.of<FrozenProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Frozen')),
      body: SingleChildScrollView(
        child: Column(children: [
        PersonajesSlider(personajes: frozenProvider.personajes)
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'logout',
        child: const Icon(Icons.exit_to_app),
        onPressed: () {
          loginForm.signOut();
          Navigator.of(context).pushNamed('login');
        },
      ),
    );
  }
}
