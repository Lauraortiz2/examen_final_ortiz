import 'dart:convert';
import 'dart:io';
import 'package:examen_final_ortiz/models/frozen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FrozenProvider extends ChangeNotifier {
  final String _baseUrl =
      'cadb49fa27bf8ac7700e.free.beeceptor.com/api/frozen/';
  final List<Frozen> personajes = [];
  late Frozen selectedPersonaje;
  File? newPicture;
  bool isLoading = true;
  bool isSaving = false;

  FrozenProvider() {
    this.loadPersonajes();
  }

  Future loadPersonajes() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl);
    final resp = await http.get(url);
    final Map<String, dynamic> frozenMap = json.decode(resp.body);

    frozenMap.forEach((key, value) {
      final tempPersonaje = Frozen.fromMap(value);
     tempPersonaje.id = key;
      personajes.add(tempPersonaje);
    });

    isLoading = false;
    notifyListeners();
  }
}