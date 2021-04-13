import 'package:flutter/material.dart';

// ListView.separeted
class ListViewSepareted extends StatefulWidget {
  @override
  _ListViewSeparetedState createState() => _ListViewSeparetedState();
}

class _ListViewSeparetedState extends State<ListViewSepareted> {

  // lista dinamica simplesmente encadeada
  var lista = [];
  var txtTarefa = TextEditingController();

  @override
  void initState() {
    super.initState();
    lista.add('Ir ao supermercado');
    lista.add('Trocar a lâmpada da cozinha');
    lista.add('Alimentar o gato');
    lista.add('Comprar pizza');
    lista.add('Abastecer o veículo');
    lista.add('Cortar o cabelo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),

        // ListView.separated
        child: ListView.separated(
          // reverse: true,
          
          // Aparencia do item
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(lista[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red[100]),
                onPressed: () {
                  setState(() {
                    lista.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tarefa removida com sucesso.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                },
              ),
            );
          },
          // Aparencia do separador
          separatorBuilder: (context,index){
            return Divider(
              color: Colors.lightBlue[100],
              thickness: 2,
            );
          }, 
          // Quantidade de itens
          itemCount: lista.length
        )
      ),

      // ADICIONAR TAREFA
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar tarefa', style: TextStyle(fontSize: 12)),
                content: TextField(
                  controller: txtTarefa,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Informe a tarefa'
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('adicionar'),
                    onPressed: () {
                      setState(() {
                        lista.add(txtTarefa.text);
                        txtTarefa.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tarefa adicionada com sucesso.'),
                            duration: Duration(seconds: 2),
                          )
                        );
                      });
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }
}