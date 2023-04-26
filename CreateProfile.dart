import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateProfile extends StatelessWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: const Image(
              image: AssetImage('images/logo.png'), fit: BoxFit.fitHeight),
        ),
      ),
      body: CreateProfileForm(),
    );
  }
}

// Create profile form widget
class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({Key? key}) : super(key: key);

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _campusStatusController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _majorController = TextEditingController();
  final _yearGroupController = TextEditingController();
  final _ashesiIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _bestFoodController = TextEditingController();
  final _bestMovieController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _campusStatusController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _majorController.dispose();
    _yearGroupController.dispose();
    _ashesiIdController.dispose();
    _dobController.dispose();
    _bestFoodController.dispose();
    _bestMovieController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final url = Uri.parse('http://127.0.0.1:5000/profiles');
    final response = await http.post(url, body: {
      'full_name': _fullNameController.text,
      'campus_status': _campusStatusController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'major': _majorController.text,
      'year_group': _yearGroupController.text,
      'ashesi_id': _ashesiIdController.text,
      'dob': _dobController.text,
      'best_food': _bestFoodController.text,
      'best_movie': _bestMovieController.text,
    });
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      //Navigator.pushNamed(context, '/Profilepage', arguments: responseData);
        const SnackBar(content: Text('Profile created successfully'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create profile')),
      );
    }
  }

//class _CreateProfileFormState extends State<CreateProfileForm> {
  @override
  Widget build(BuildContext context) {
    //create a page where user can scroll to sign up
    return Form(child: ListView(

      children: [
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),

          child: TextField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.accessibility),
              hintText: 'Full name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          //height: 10.0,
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _campusStatusController,
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'On or Off-campus',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'someone@ashesi.edu.com',
              border: OutlineInputBorder(),
            ),

          ),
        ),

        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),

          child: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.security),
              hintText: 'password',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _majorController,
            decoration: const InputDecoration(
              icon: Icon(Icons.school_outlined),
              hintText: 'Ashesi Major',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _yearGroupController,
            decoration: const InputDecoration(
              icon: Icon(Icons.group_add),
              hintText: 'Year Group',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _ashesiIdController,
            decoration: const InputDecoration(
              icon: Icon(Icons.numbers),
              hintText: 'Ashesi ID',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller:_dobController,
            decoration: const InputDecoration(
              icon: Icon(Icons.date_range),
              hintText: 'Date of Birth',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _bestFoodController,
            decoration: const InputDecoration(
              icon: Icon(Icons.fastfood),
              hintText: 'Best food',
              border: OutlineInputBorder(),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: TextField(
            controller: _bestMovieController,
            decoration: const InputDecoration(
              icon: Icon(Icons.movie),
              hintText: 'Best movie',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
          child: ElevatedButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      if
                      (states.contains(MaterialState.hovered)) {
                        return Colors.redAccent;
                      }
                      return null;

                    }
                )
            ),
            onPressed: () async {

              _submitForm();
              Navigator.pushNamed(context, '/second');
              final name = _fullNameController.text;
              final campus = _campusStatusController.text;
              final email = _emailController.text;
              final password = _passwordController.text;
              final major = _majorController.text;
              final yearGroup = _yearGroupController.text;
              final id = _ashesiIdController.text;
              final dob = _dobController.text;
              final food = _bestFoodController.text;
              final movie =  _bestMovieController.text;

              //final url = 'http://127.0.0.1:5000/profile';

              final data = {
                'name': name,
                'campus': campus,
                'email': email,
                'password': password,
                'major': major,
                'yearGroup': yearGroup,
                'id': id,
                'dob': dob,
                'food': food,
                'movie': movie,
                 };


            }, child: const Text('Sign Up'),),
        ),
      ],

    ),

    );
  }
}
