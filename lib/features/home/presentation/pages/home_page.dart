import 'package:flutter/material.dart';
import 'package:litlens_v1/features/home/presentation/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      // APPBAR
      appBar: AppBar(centerTitle: true, title: const Text("LitLens")),
      // DRAWER
      drawer: MyDrawer(),
    );
  }
}
