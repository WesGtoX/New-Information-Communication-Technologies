import 'package:flutter/material.dart';
import 'CarroWidget.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carros',
      home: TelaPrincipal(),

      theme: ThemeData(
        primaryColor: Colors.blue[900],
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
          ),
          headline3: TextStyle(
            fontSize: 24, 
            fontStyle: FontStyle.italic, 
          ),
        )
      ),
    )
  );
}

class TelaPrincipal extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Carros', 
          style: Theme.of(context).textTheme.headline1
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarroWidget('Audi','Q8','lib/images/audi_q8.jpg'),
            CarroWidget('Audi','R8','lib/images/audi_r8.jpg'),
            CarroWidget('BMW','M2','lib/images/bmw_m2.jpg'),
            CarroWidget('Ferrari','488','lib/images/ferrari_488.jpg'),
            CarroWidget('Lamborghini','Huracan','lib/images/lamborghini_huracan.jpg'),
            CarroWidget('Lamborghini','Urus','lib/images/lamborghini_urus.jpg'),
            CarroWidget('Maserati','GTS','lib/images/maserati_gts.jpg'),
          ],
        ),
      ),
    );
  }
}
