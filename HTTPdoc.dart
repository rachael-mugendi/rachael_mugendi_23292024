import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPdoc {
  //--Showing all posts

  Future<Map> getpost(postID) async {
    Map post = {};

    //Get the item from the API
    http.Response response = await http
        .get(Uri.parse('http://127.0.0.1:5000/$postID'));

    if (response.statusCode == 200) {
      //get the data from the response
      String jsonString = response.body;
      //Convert to List<Map>
      post = jsonDecode(jsonString);
    }

    return post;
  }

  //-- Add a new item
  Future<bool> addItem(Map data) async {
    bool status = false;

    //Add the item to the database, call the API
    http.Response response = await http
        .post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {
          'Content-type':'application/json'
        }
    );

    if(response.statusCode==201)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }

//-- Update an item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    //Update the item, call the API
    http.Response response = await http
        .put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {
          'Content-type':'application/json'
        }
    );

    if(response.statusCode==200)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }

  //--Delete an item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    //Delete the item from the Database
    http.Response response=await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),);

    if(response.statusCode==200)
    {
      status=true;
    }

    return status;
  }
}