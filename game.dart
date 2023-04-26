import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/cupertino.dart';

import 'package:rachael_mugendi23292024/Feed.dart';
import 'package:rachael_mugendi23292024/Profilepage.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const game());

}

class game extends StatelessWidget {
  const game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dicy game'),
          backgroundColor: Colors.red,
        ),
        body: dicy(),

        bottomNavigationBar: BottomAppBar(
          color: CupertinoColors.separator,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/first');
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },

              ),
              IconButton(
                icon:  const Icon(
                  DiceIcons.dice5,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fourth');
                },
              ),

              IconButton(
                icon:  const Icon(
                  Icons.account_balance_sharp,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fifth');
                },
              ),

              IconButton(
                icon:  const Icon(
                  Icons.accessibility,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sixth');
                },
              ),

            ],
          ),
        ),
      ),

    );
  }
}


class dicy extends StatefulWidget {

  @override
  State<dicy> createState() => _dicyState();
}

class _dicyState extends State<dicy> {
  int leftDiceNumber = 5;
  int rightDiceNumber = 4;

  void actions(){
    leftDiceNumber = Random().nextInt(6)+1;
    rightDiceNumber = Random().nextInt(6)+1;
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: (){
                setState(() {
                  actions();
                });

              },
              child: Image.asset('images/dice$leftDiceNumber.png'),


            ),
          ),
          Expanded(
            child: TextButton(
                onPressed: (){
                  setState((){
                    actions();
                  });

                },
                child: Image.asset('images/dice$rightDiceNumber.png')

            ),
          ),

        ],
      ),
    );
  }

}