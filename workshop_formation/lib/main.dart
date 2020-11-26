/*
 * Dart & Flutter - Training
 * 
 * Copyright (c) Boris-Wilfried Nyasse
 * All rights reserved
*/

import 'package:flutter/material.dart';

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

void main() {
  runApp(MaterialApp(
    title: 'Navigation Imperative',
    onGenerateRoute: (settings) {
      //RESOLUTION: Faire une navigation intelligente
      if (settings.name == '/') {
        return MaterialPageRoute(builder: (context) => Screen1());
      } else if (settings.name == '/second') {
        return MaterialPageRoute(
          builder: (context) {
            return Screen2(
              args: settings.arguments,
            );
          },
        );
      }
      return MaterialPageRoute(builder: (context) => UnknownScreen());
    },
  ));
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecran N°1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('via le push : Naviguer vers l\'écran N°2'),
          //RESOLUTION: Implémenter la navigation vers un autre écran nommé
          onPressed: () {
            //RESOLUTION : Passer l'argument lors de la navigation
            Navigator.pushNamed(
              context,
              '/second',
              arguments: ScreenArguments('arg-title', 'arg-message'),
            );
          },
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  final ScreenArguments args;

  const Screen2({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecran N°2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //RESOLUTION: afficher le title de l'argument
            Text('Arg title is ${args.title}'),
            //RESOLUTION: afficher le message de l'argument
            Text('Arg message is ${args.message}'),
            ElevatedButton(
              //RESOLUTION: Implémenter la navigation retour
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('via le pop : retour à l\'écran précédent'),
            ),
          ],
        ),
      ),
    );
  }
}
