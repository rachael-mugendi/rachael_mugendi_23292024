import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dice_icons/dice_icons.dart';

class Profile {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? major;
  final String? year_group;
  final String? date_of_birth;
  final String? on_offcampus;
  final String? best_food;
  final String? best_movie;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.major,
    required this.year_group,
    required this.date_of_birth,
    required this.on_offcampus,
    required this.best_food,
    required this.best_movie,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      major: json['major'],
      year_group: json['year_group'],
      date_of_birth: json['date_of_birth'],
      on_offcampus: json['on_offcampfus'],
      best_food: json['best_food'],
      best_movie: json['best_movie'],
    );
  }
}

class AllUsersScreen extends StatefulWidget {
  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  late Future<List<Profile>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchProfile();
  }

  Future<List<Profile>> fetchProfile() async {
    List<Profile> users = [];

    http.Response response = await http.get(Uri.parse('http://127.0.0.1:5000/profiles'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      users = data.map((profile) => Profile.fromJson(profile)).toList();
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Profiles'),
      ),
      body: Center(
        child: FutureBuilder<List<Profile>>(
          future: futureUsers,
          builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Profile> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //leading: Text(users[index].name ?? 'Name not available'),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // aligns text to the left
                        children: [
                          Text(users[index].name ?? 'Name not available', selectionColor: Colors.blueAccent,),
                          Text(users[index].email ?? 'Email not available'),
                          Text(users[index].major ?? 'Major not available'),
                          Text(users[index].year_group ?? 'Year group not available'),
                          Text(users[index].date_of_birth ?? 'Date of birth not available'),
                          Text(users[index].on_offcampus ?? 'On/Off campus not available'),
                          Text(users[index].best_food ?? 'Best food not available'),
                          Text(users[index].best_movie ?? 'Best movie not available'),
                          Text(users[index].password ?? 'Password not available'),
                          Text(users[index].id ?? 'ID not available'),
                          SizedBox(height: 10), // adds space between profiles
                        ],
                      ),
                    ),
                  );

                },
              );
            }
          },
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
    );
  }
}
