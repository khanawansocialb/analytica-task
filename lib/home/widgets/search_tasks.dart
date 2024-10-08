import 'package:flutter/material.dart';

class SearchTasksField extends StatelessWidget {
  ///we'd accept a call back 
  ///to control the state of the parent
  
  final ValueChanged<String> onSearchChanged;

  const SearchTasksField({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Search Tasks',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}