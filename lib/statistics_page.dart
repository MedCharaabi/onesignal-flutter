import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatisticsPage extends HookWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: const Center(
        child: Text(
          'Statistics',
          style: TextStyle(fontSize: 44),
        ),
      ),
    );
  }
}

 

 