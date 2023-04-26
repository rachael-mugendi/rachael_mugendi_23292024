import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dice_icons/dice_icons.dart';



void main() {
  runApp(Profilepage());
}



class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black45,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('images/fashion10.jpg'),
              ),
              Text(
                'Safari Mugendi',
                style: TextStyle(
                  fontFamily: 'Gloria Hallelujah',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Management Information Systems',
                style: TextStyle(
                  fontFamily: 'Gloria Hallelujah',
                  fontSize: 25.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '2024',
                style: TextStyle(
                  fontFamily: 'Indie Flower',
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.black,
                ),
              ),

              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(Icons.email_outlined,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  title: Text(
                    'rachael.mugendi@ashesi.edu.gh',
                    style: TextStyle(
                      fontFamily: 'Indie Flower',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(Icons.movie_creation_outlined,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  title: Text(
                    ' How to get Away with murder',
                    style: TextStyle(
                      fontFamily: 'Indie Flower',
                      fontSize: 20.0,
                    ),
                  ),
                ),



              ),

              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(Icons.fastfood,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Ugali and Eggs',
                    style: TextStyle(
                      fontFamily: 'Indie Flower',
                      fontSize: 20.0,
                    ),
                  ),
                ),



              ),

              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(Icons.maps_home_work_outlined,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  title: Text(
                    'On-campus',
                    style: TextStyle(
                      fontFamily: 'Indie Flower',
                      fontSize: 20.0,
                    ),
                  ),
                ),



              ),

            ],
          ),
        ),

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