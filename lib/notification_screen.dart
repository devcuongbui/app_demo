import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.markunread),
                          title: Text('Unread'),
                          onTap: () {
                            // Handle selection
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.category),
                          title: Text('All categories'),
                          onTap: () {
                            // Handle selection
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Me'),
                          onTap: () {
                            // Handle selection
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.comment),
                          title: Text('Comment'),
                          onTap: () {
                            // Handle selection
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.notifications),
            ),
            title: Text('Notification ${index + 1}'),
            subtitle: Text('This is a notification.'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Do something when a notification is tapped
            },
          );
        },
      ),
    );
  }
}
