import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BingStar"),
        actions: [
          TextField(
            controller: searchInput,
            decoration: const InputDecoration(hintText: "Search..."),
            style:
                const TextStyle(fontSize: 30, color: Colors.deepPurpleAccent),
          )
        ],
      ),
      body: Container(),
    );
  }
}
