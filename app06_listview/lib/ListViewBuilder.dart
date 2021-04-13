import 'package:flutter/material.dart';

// ListView.builder
class ListViewBuilder extends StatefulWidget {
  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.builder'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [

          // HORIZONTAL
          Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
            height: 320,

            // ListView.builder
            child: ListView.builder(
              // Orientacao
              scrollDirection: Axis.horizontal,
              // Aparencia o item da lista
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 200,
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Text('Item $index')),
                );
              },
              // Quantidade de itens
              itemCount: 20,
            ),
          ),

          // VERTICAL
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Row(
                      children:[
                        Image.network('https://picsum.photos/id/${index+1}/160'),  
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Mussum Ipsum, cacilds vidis litro abertis. Não sou faixa preta cumpadi, '
                              'sou preto inteiris, inteiris. Per aumento de cachacis, eu reclamis. '
                              'Quem manda na minha terra sou euzis! Cevadis im ampola pa arma uma pindureta.'
                            )
                          )
                        )
                      ]
                    ),
                  );
                },
                // Quantidade de itens
                itemCount: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}