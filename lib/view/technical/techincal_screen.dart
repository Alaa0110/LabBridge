// lib/views/success_page.dart
import 'package:flutter/material.dart';

class TechnicalPage extends StatelessWidget {
  const TechnicalPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text('Technical Page')),
      body: const Center(
        child: Text('First Name: ', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
