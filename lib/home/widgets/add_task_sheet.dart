import 'package:flutter/material.dart';
import 'package:the_app/config/app_size.dart';

class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.appHeight / 2,
      child: const Padding(
        padding:  EdgeInsets.all(20.0),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Title"
              ),
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Description"
              ),
            )
          ],
        ),
      ),
    );
  }
}
