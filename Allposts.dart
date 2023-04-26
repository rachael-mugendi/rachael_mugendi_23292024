import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dice_icons/dice_icons.dart';

class Post {
  final String id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['postId'],
      title: json['title'],
      body: json['content'],
    );
  }
}

class AllPostsScreen extends StatefulWidget {
  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    List<Post> posts = [];

    http.Response response = await http.get(Uri.parse('http://127.0.0.1:5000/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      posts = data.map((post) => Post.fromJson(post)).toList();
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posts'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Post> posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(posts[index].title),
                    subtitle: Text(posts[index].body),
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
