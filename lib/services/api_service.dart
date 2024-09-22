import 'package:http/http.dart' as http;
import 'package:postapi/models/model.dart';
import 'dart:convert';

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

 
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()), 
    );

    if (response.statusCode == 201) {
      
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }
}
