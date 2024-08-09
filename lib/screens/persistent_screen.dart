import 'package:flutter/material.dart';

class PersistentScreen extends StatelessWidget {
  final Widget child;

  const PersistentScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi FAB
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
