import 'package:flutter/material.dart';

void main() {
  // Indicar a 1a tela do App que sera exibida
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App02',
    home: MainScreen()
  ));
}

// Main screen
class MainScreen extends StatelessWidget {
  // O metodo BUILD eh responsavel por CONSTRUIR
  // os Widgets que serao exibidos na tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first App'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Text 1', style: TextStyle(fontSize: 24)),
          
          Icon(Icons.pets_outlined, size: 40, color: Colors.deepPurple),

          Text('Text 2', style: TextStyle(fontSize: 24)),
          Text('Text 3', style: TextStyle(fontSize: 24)),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.red
              ),
              Column(
                children: [
                  Icon(Icons.pets),
                  Icon(Icons.pets),
                  Icon(Icons.pets),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.green,
                child: Column(
                  children: [
                    Text('A'),
                    Text('B'),
                    Text('C'),
                  ],
                )
              ),
              Expanded(
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
              )
            ]
          ),
          Text('Text 4', style: TextStyle(fontSize: 24)),
          Text('Text 5', style: TextStyle(fontSize: 24)),
          Expanded(
            child: Container(
              width: 80,
              height: 80,
              color: Colors.yellow
            ),
          )
        ],
      ),
      // Text('Text 4', style: TextStyle(fontSize: 24)),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}
