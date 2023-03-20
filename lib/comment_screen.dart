import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          'Comments:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: Container(
            height: 200.0,
            child: ListView.builder(
              itemCount: 10, // replace with actual number of comments
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/avatar_user1.jpg',
                      // Here you can add image that will represent user
                    ),
                  ),
                  title: Text('User $index'),
                  subtitle: Text('Comment $index'),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
