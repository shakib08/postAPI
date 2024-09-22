import 'package:flutter/material.dart';
import 'package:postapi/models/model.dart';
import '../services/api_service.dart';

class PostDataScreen extends StatefulWidget {
  @override
  _PostDataScreenState createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  Post? _postedData;


  void _submitData() async {
    setState(() {
      _isLoading = true;
    });

    Post newPost = Post(
      userId: 1, 
      title: _titleController.text,
      body: _bodyController.text,
    );

    try {
      Post createdPost = await _apiService.createPost(newPost);
      setState(() {
        _postedData = createdPost;
      });
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitData,
                    child: Text('Submit'),
                  ),
            SizedBox(height: 20),
            if (_postedData != null)
              Column(
                children: [
                  Text('Post Created Successfully!'),
                  Text('ID: ${_postedData!.id}'),
                  Text('Title: ${_postedData!.title}'),
                  Text('Body: ${_postedData!.body}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
