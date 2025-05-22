import 'package:examen_final_ortiz/models/frozen.dart';
import 'package:flutter/material.dart';

class PersonajeDetailsScreen extends StatelessWidget {
  const PersonajeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Frozen personaje = ModalRoute.of(context)?.settings.arguments as Frozen;

    return Scaffold(
appBar: AppBar(
  title: Text('Detalles de los personajes'),
),
      backgroundColor: const Color.fromARGB(255, 171, 202, 216),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:( _Overview(personaje: personaje)),
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Frozen personaje;
  final TextStyle titulo = const TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  final TextStyle info = const TextStyle(
    color: Colors.deepPurple,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );

  const _Overview({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Nombre: ',
              style: titulo,
              children: <TextSpan>[TextSpan(text: personaje.nom, style: info)],
            ),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Descripción: ',
              style: titulo,
              children: <TextSpan>[
                TextSpan(text: personaje.descripcio, style: info),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Fecha de nacimiento: ',
              style: titulo,
              children: <TextSpan>[
                TextSpan(text: personaje.fechaNacimiento, style: info),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Color de ojos: ',
              style: titulo,
              children: <TextSpan>[TextSpan(text: personaje.colorOjos, style: info)],
            ),
          ),
          FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(personaje.foto),
            height: 150,
          ),
        ],
      ),
    );
  }
}
