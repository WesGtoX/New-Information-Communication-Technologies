import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navegação',

    // ROTAS DE NAVEGAÇÃO
    initialRoute: '/primeira',
    routes: {
      '/primeira': (context) => PrimeiraTela(),
      '/segunda': (context) => SegundaTela(),
      '/terceira': (context) => TerceiraTela(),
      '/quarta': (context) => QuartaTela(),
    },
  ));
}

// MODELO DE DADOS
// Este modelo de dados sera utilizado para 
// troca de dados entre as telas do App
class Mensagem{
  final String titulo;
  final String conteudo;
  Mensagem(this.titulo,this.conteudo);
}

// PRIMEIRA TELA
class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {

  var txtTitulo = TextEditingController();
  var txtConteudo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Primeira Tela')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, 
          children: [
          OutlinedButton(
            child: Text('Próximo'),
            onPressed: () {
              // Navegar para SegundaTela
              Navigator.pushNamed(context, '/segunda');
            },
          ),
          SizedBox(height: 40),
          TextField(
            controller: txtTitulo,
            decoration: InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: txtConteudo,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: 'Conteúdo',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(height: 10),
          
          // TROCA DE DADOS ENTRE AS TELAS
          OutlinedButton(
            child: Text('enviar'),
            onPressed: () {
              
              var msg = Mensagem(
                txtTitulo.text,
                txtConteudo.text
              );
              
              Navigator.pushNamed(context, '/segunda', arguments: msg);
            },
          ),
        ]),
      ),
    );
  }
}

// SEGUNDA TELA
class SegundaTela extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Receber o objeto da classe Mensagem
    Mensagem msg = ModalRoute.of(context).settings.arguments;
    if (msg == null) {
      msg = Mensagem('', '');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
        // Remover o icone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Text('Anterior'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                OutlinedButton(
                  child: Text('Próximo'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/terceira');
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            Text('Título', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            Text(msg.titulo, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Conteúdo', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            Text(msg.conteudo, style: TextStyle(fontSize: 24)),
        ]),
      ),
    );
  }
}

// TERCEIRA TELA
class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terceira Tela'),
        // Remover o icone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Text('Anterior'),
                  onPressed: () {
                    // Voltar para PrimeiraTela()
                    Navigator.pop(context);
                  },
                ),
                OutlinedButton(
                  child: Text('Próximo'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/quarta');
                  },
                ),
              ],
            ),
        ]),
      ),
    );
  }
}

// QUARTA TELA
class QuartaTela extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quarta Tela'),
        // Remover o icone de Voltar
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Text('Anterior'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
        ]),
      ),
    );
  }
}
