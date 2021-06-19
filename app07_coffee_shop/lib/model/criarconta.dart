import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaCriarConta extends StatefulWidget {
  @override
  _TelaCriarContaState createState() => _TelaCriarContaState();
}

class _TelaCriarContaState extends State<TelaCriarConta> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Café Store'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtNome,
              style: TextStyle(
                color: Colors.brown, 
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), 
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: txtEmail,
              style: TextStyle(
                color: Colors.brown, 
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email), 
                labelText: 'E-mail',
              ),
            ),
            SizedBox(height: 20),
            
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: TextStyle(
                color: Colors.brown, 
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock), 
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('criar'),
                    onPressed: () {
                      criarConta(txtNome.text, txtEmail.text, txtSenha.text);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: Text('cancelar'),
                    onPressed: () { Navigator.pop(context); },
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // CRIAR CONTA no Firebase Auth
  void criarConta(nome, email, senha){

    FirebaseAuth fa = FirebaseAuth.instance;

    fa.createUserWithEmailAndPassword(email: email, password: senha)
      .then((resultado){

        //armazenar dados da conta no Firestore
        var db = FirebaseFirestore.instance;
        db.collection('usuarios').doc(resultado.user!.uid).set({
            'nome' : nome,
            'email': email,
          }
        ).then((valor){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuário criado com sucesso.'),
              duration: Duration(seconds: 2),
            )
          );
        });

    }).catchError((error) {
      var errorCode = error.code;
      var message = '';

      if (errorCode == 'email-already-in-use') {
        message = 'O e-mail informado já está em uso';
      } else {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERRO: $message'),
          duration: Duration(seconds: 2),
        )
      );
      Navigator.pop(context);
    });
  }
}
