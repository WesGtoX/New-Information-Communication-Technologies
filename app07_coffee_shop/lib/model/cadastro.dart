import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  //Recuperar um DOCUMENTO a partir do ID
  void getDocumentById(String id) async {
    await FirebaseFirestore.instance
        .collection('cafes').doc(id).get()
        .then((value) {
          txtNome.text = value.data()!['nome'];
          txtPreco.text = value.data()!['preco'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o ID que foi passado como argumento
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text == '' && txtPreco.text =='') {
        getDocumentById(id.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Café Store'),
          centerTitle: true,
          backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(children: [
          TextField(
            controller: txtNome,
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              labelText: 'Nome',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: txtPreco,
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              labelText: 'Preço',
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: OutlinedButton(
                    child: Text('salvar'),
                    onPressed: () {
                      var db = FirebaseFirestore.instance;

                      if (id == null) {
                        //Adicionar um novo documento
                        db.collection('cafes').add({
                          "nome": txtNome.text,
                          "preco": txtPreco.text,
                        });
                      } else {
                        //Atualizar um documento
                        db.collection('cafes').doc(id.toString()).update(
                          {
                            "nome": txtNome.text,
                            "preco": txtPreco.text,
                          }
                        );
                      }

                      Navigator.pop(context);
                    }),
              ),
              Container(
                width: 150,
                child: OutlinedButton(
                    child: Text('cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
