import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Êtes-vous sûr de vouloir quitter ?'),
      actions: [
        TextButton(
          onPressed: () {
            // Fermer la boîte de dialogue et revenir à l'application
            Navigator.of(context).pop(false);
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Fermer la boîte de dialogue et quitter l'application
            Navigator.of(context).pop(true);
          },
          child: const Text('Quitter'),
        ),
      ],
    );
  }
}
