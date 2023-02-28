import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
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
