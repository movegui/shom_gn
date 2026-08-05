import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ReklamationWidget extends StatelessWidget {
  const ReklamationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ReclamationScreen();
    /*
    MaterialApp(
      title: 'Formulaire de Contact MoveGui',
      debugShowCheckedModeBanner: false,
      home: ReclamationScreen(),
    );
    */
  }
}

class ReclamationScreen extends StatefulWidget {
  const ReclamationScreen({super.key});

  @override
  _ReclamationScreenState createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reclamationController = TextEditingController();

  void _envoyerReclamation() {
    if (_formKey.currentState!.validate()) {
      final message = _reclamationController.text;

      // Ici vous pouvez envoyer la réclamation à votre serveur ou la traiter comme souhaité
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Réclamation envoyée'),
          content: Text('Merci pour votre message :\n\n$message'),
          actions: [
            TextButton(
              child: Text('Fermer'),
              onPressed: () =>    context.pop()      
            )
          ],
        ),
      );

      // Réinitialise le champ après envoi
      _reclamationController.clear();
    }
  }

  @override
  void dispose() {
    _reclamationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    /*
    Scaffold(

      appBar: AppBar(
        title: Text('Formulaire de Réclamation'),
        backgroundColor: Colors.blueAccent,
      ),
      body: 
      */
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Décrivez votre problème ou réclamation ci-dessous :',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _reclamationController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Votre message...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer votre réclamation.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Envoyer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: _envoyerReclamation,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
