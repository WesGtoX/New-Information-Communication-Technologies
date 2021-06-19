import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'model/cadastro.dart';
import 'model/cafe.dart';
import 'model/login.dart';
import 'model/criarconta.dart';

Future<void> main() async {
  // Inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/principal': (context) => TelaPrincipal(uid: ''),
        '/cadastro': (context) => TelaCadastro(),
        '/login': (context) => TelaLogin(),
        '/criarconta': (context) => TelaCriarConta(),
      },
    )
  );

  // Teste Firebase
  // var db = FirebaseFirestore.instance;

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

  final String uid;
  TelaPrincipal({ required this.uid });

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  // Instancia do Firestore
  // var db = FirebaseFirestore.instance;

  // Lista dinamica de objetos do modelo Cafe
  // List<Cafe> cafes = [];

  // Declaracao de um "ouvidor", que tem como objetico 
  // monitorar as alteracoes realizadas na colecao
  // StreamSubscription<QuerySnapshot> query;

  // Referencia a colecao nomeada "cafes" do Firestore
  late CollectionReference cafes;
  late CollectionReference usuarios;
  late String nome = '';

  @override
  void initState() {
    super.initState();
    cafes = FirebaseFirestore.instance.collection('cafes');
    usuarios = FirebaseFirestore.instance.collection('usuarios');

    retornarUsuario().whenComplete(() {
        setState(() {});
    });
  }

  Future<Null> retornarUsuario() async {
    await usuarios.doc(widget.uid).get().then((value) {
      setState(() {
        nome = value['nome'].toString();
      });
    });
  }

  Widget itemLista(item) {
    Cafe cafe = Cafe.fromJson(item.data(), item.id);
    
    return ListTile(
      title: Text(cafe.nome, style: TextStyle(fontSize: 24)),
      subtitle: Text(cafe.preco, style: TextStyle(fontSize: 18)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Apagar um café
          cafes.doc(cafe.id).delete();
        },
      ),

      onTap: () {
        Navigator.pushNamed(context, '/cadastro', arguments: cafe.id);
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text('Café Store'),
            ),
            Container(
              child: Text('$nome'),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),

      // Exibir os documentos
      body: StreamBuilder<QuerySnapshot>(
        
        // Fonte de dados
        // stream: db.collection('cafes').snapshots(),
        
        // fonte de dados
        stream: cafes.snapshots(),

        // Aparencia
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Erro ao conectar no Firebase'));

            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            default:
              final dados = snapshot.requireData;

              return ListView.builder(
                itemCount: dados.size,
                itemBuilder: (context, index) {

                  // Cafe cafe = Cafe.fromJson(
                  //   dados.docs[index].data().toString(),
                  //   dados.docs[index].id
                  // )

                  // return ListTile(
                  //   title: Text(cafes[index].nome, style: TextStyle(fontSize: 24)),
                  //   subtitle: Text(cafes[index].preco, style: TextStyle(fontSize: 18)),

                  //   trailing: IconButton(
                  //     icon: Icon(Icons.delete),
                  //     onPressed: () {
                        
                  //       // Apagar um cafe
                  //       cafes.doc(cafe.id).delete(),
                  //       db.collection('cafe').doc(cafes[index].id).delete();
                  //     },
                  //   ),
                  // );

                  return itemLista(dados.docs[index]);
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
          Navigator.pushNamed(context, '/cadastro');
        },
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}
