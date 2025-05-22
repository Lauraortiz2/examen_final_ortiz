import 'package:examen_final_ortiz/models/frozen.dart';
import 'package:flutter/material.dart';

class PersonajesSlider extends StatelessWidget {
  final List<Frozen> personajes;

  const PersonajesSlider({super.key, required this.personajes});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (personajes.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 270,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Frozen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: personajes.length,
                itemBuilder: (_, int index) =>
                    _PersonajesNombre(personaje: personajes[index])),
          )
        ],
      ),
    );
  }
}

class _PersonajesNombre extends StatelessWidget {
  final Frozen personaje;

  const _PersonajesNombre({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
           onTap: () => Navigator.pushNamed(context, 'personajesDetails',
                arguments: personaje),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:Text(
            personaje.nom,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
            ),
          ),
        ],
      ),
    );
  }
}