import 'package:flutter/material.dart';

// MENU PRINCIPAL
class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu'), centerTitle: true),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.all(40),

        // LISTVIEW
        child: ListView(
          children: [
            Icon(Icons.list,size:120,color:Colors.grey),
            Text(
              'O widget ListView permite adicionar uma lista de itens roláveis', 
              style: TextStyle(fontSize: 18, color:Colors.grey, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 40),

            ListTile(
              leading: Icon(Icons.label, color: Colors.grey),
              trailing: Icon(Icons.build, color: Colors.grey),
              title: Text('ListView.builder', style: TextStyle(fontSize: 32, color:Colors.grey)),
              subtitle: Text(
                'O construtor builder() é utilizado para repetir um conjunto de itens. ', 
                style: TextStyle(fontSize: 14, color:Colors.grey, fontStyle: FontStyle.italic)
              ),
              onTap: () {
                print('item pressionado');
                Navigator.pushNamed(context, '/list1');
              },
              hoverColor: Colors.blue[100],
            ),

            ListTile(
              leading: Icon(Icons.label, color: Colors.grey),
              trailing: Icon(Icons.build, color: Colors.grey),
              title: Text('ListView.separeted', style: TextStyle(fontSize: 32, color:Colors.grey)),
              subtitle: Text(
                'O construtor separeted() é utilizado para repetir um conjunto de itens com um separador. ', 
                style: TextStyle(fontSize: 14, color:Colors.grey, fontStyle: FontStyle.italic)
              ),
              onTap: () {
                print('item pressionado');
                Navigator.pushNamed(context, '/list2');
              },
              hoverColor: Colors.blue[100],
            ),
          ],
        ),
      ),
    );
  }
}
