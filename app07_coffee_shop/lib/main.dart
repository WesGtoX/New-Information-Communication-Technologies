import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'model/cafe.dart';

Future<void> main() async {
  // Inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/principal',
      routes: {
        '/principal': (context) => TelaPrincipal(),
      },
    )
  );

  // Teste Firebase
  var db = FirebaseFirestore.instance;

  // adicionar um novo documento
  /*
  db.collection('cafes').add({
    "nome": "Café Melita 500g",
    "preco": "R\$ 9,85"
  });
  
  db.collection('cafes').doc("cafe001").set({
    "nome": "Café Melita 500g",
    "preco": "R\$ 9,85"
  });
  
  Cafe cafe = Cafe('', 'Café Utam 1kg', 'R\$ 25,65');
  db.collection('cafes').add(cafe.toJson());
  */
}

// TelaPrincipal
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  // Instancia do Firestore
  var db = FirebaseFirestore.instance;

  // Lista dinamica de objetos do modelo Cafe
  List<Cafe> cafes = [];

  // Declaracao de um "ouvidor", que tem como objetico 
  // monitorar as alteracoes realizadas na colecao
  StreamSubscription<QuerySnapshot> query;

  @override
  void initState() {
    super.initState();

    // Registrar o "ouvidor" e iniciar o monitoramento

    // Destruir o "ouvidor" atual, caso ele exista
    query?.cancel();

    query = db.collection('cafes').snapshots().listen((event) {
      // Atualizar a lista de Cafes
      setState(() {
        cafes = event.docs.map(
          (e) => Cafe.fromMap(e.data(), e.id)
        ).toList();
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Café Store'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),

      // Exibir os documentos
      body: StreamBuilder<QuerySnapshot>(
        
        // Fonte de dados
        stream: db.collection('cafes').snapshots(),

        // Aparencia
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Erro ao conectar no Firebase'));

            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            default:
              return ListView.builder(
                itemCount: cafes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cafes[index].nome, style: TextStyle(fontSize: 24)),
                    subtitle: Text(cafes[index].preco, style: TextStyle(fontSize: 18)),

                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        
                        // Apagar um cafe
                        db.collection('cafe').doc(cafes[index].id).delete();
                      },
                    ),
                  );
                }
              );
          }
        },
      ),

      // Adicionar novos cafes
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}
