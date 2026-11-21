import 'package:flutter/material.dart';

class TrendingMoviesPage extends StatelessWidget {
  const TrendingMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TENDENCIAS')),
      body: Center(
        child: Text(
          'Proximamente: lista de tendencias',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
