import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/priere.dart';

class PriereService {
  static List<Priere> _prieres = [];

  static Future<void> loadPrieres() async {
    if (_prieres.isEmpty) {
      String jsonString = await rootBundle.loadString('data/vavaka.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> prieresJson = jsonData['prieres'];
      _prieres = prieresJson.map((json) => Priere.fromJson(json)).toList();
    }
  }

  static List<Priere> getPrieres() {
    return _prieres;
  }

  static List<Priere> getPrieresByCategorie(String categorie) {
    return _prieres.where((p) => p.categorie == categorie).toList();
  }

  static List<String> getCategories() {
    return _prieres.map((p) => p.categorie).toSet().toList();
  }

  static Priere? getPriereById(int id) {
    try {
      return _prieres.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}