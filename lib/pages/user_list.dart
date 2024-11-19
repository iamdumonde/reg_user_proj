import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reg_user_proj/models/user.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> _users = []; // Liste des utilisateurs
  bool _isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // récupérer les utilisateurs au démarrage
  }

  //Méthode pour récupérer les utilisateurs depuis l'API
  Future<void> _fetchUsers() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8081/getAllUsers'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _users = data.map((json) => User.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Erreur serveur : ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Afficher une erreur si nécessaire
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Utilisateurs'),
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Afficher un loader pendant le chargement
          : _users.isEmpty
              ? const Center(
                  child: Text(
                      'Aucun utilisateur trouvé.')) // Afficher un message si la liste est vide
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return ListTile(
                      leading: CircleAvatar(
                          child: Text(user.name[0])), // Première lettre du nom
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    );
                  }),
    );
  }
}
