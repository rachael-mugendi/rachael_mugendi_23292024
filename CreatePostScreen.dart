import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/cupertino.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _IdController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();


  Future<void> _createPost() async {
    final url = Uri.parse('http://127.0.0.1:5000/posts');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      'postId': _IdController.text,
      'title' : _titleController.text,
      'content': _bodyController.text,
      'email' : _emailcontroller.text,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _IdController,
              decoration: InputDecoration(
                hintText: 'Enter post Id',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),

            SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 16),

            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(
                hintText: 'Post',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 16),

            TextFormField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                hintText: 'email',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 16),


            ElevatedButton(
              onPressed: _createPost,
              child: Text('Create Post'),
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
    );
  }
}

