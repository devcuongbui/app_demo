import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = "All categories"; // initialize filter value
  List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'notification type': 'Unread',
      'notificationMessage':
          'Do_Xuan_Nam changed the expiration date of tag "tag 1" in table "Table 1", on Mar 11, 2023 at 15:49',
      'notificationIcon':
          Icons.table_chart_outlined, // icon for Unread notification type
    },
    {
      'id': 2,
      'notification type': 'All categories',
      'notificationMessage':
          'Do_Xuan_Nam changed the expiration date of tag "tag 1" in table "Table 1", on Mar 11, 2023 at 15:49',
      'notificationIcon':
          Icons.notifications, // icon for All categories notification type
    },
    {
      'id': 3,
      'notification type': 'Me',
      'notificationMessage':
          'Do_Xuan_Nam changed the expiration date of tag "tag 1" in table "Table 1", on Mar 11, 2023 at 15:49',
      'notificationIcon': Icons.person, // icon for Me notification type
    },
    {
      'id': 4,
      'notification type': 'Comment',
      'notificationMessage':
          'Do_Xuan_Nam changed the expiration date of tag "tag 1" in table "Table 1", on Mar 11, 2023 at 15:49',
      'notificationIcon': Icons.comment, // icon for Comment notification type
    },
    {
      'id': 5,
      'notification type': 'Comment',
      'notificationMessage':
          'Do_Xuan_Nam changed the expiration date of tag "tag 1" in table "Table 1", on Mar 11, 2023 at 15:49',
      'notificationIcon':
          Icons.table_chart_outlined, // icon for Comment notification type
    },
  ];

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
                            setState(() {
                              _selectedFilter = "Unread";
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == "Unread",
                          trailing: _selectedFilter == "Unread"
                              ? Icon(Icons.circle, color: Colors.red, size: 12)
                              : null,
                        ),
                        ListTile(
                          leading: Icon(Icons.category),
                          title: Text('All categories'),
                          onTap: () {
                            // Handle selection
                            setState(() {
                              _selectedFilter = "All categories";
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == "All categories",
                          trailing: _selectedFilter == "All categories"
                              ? Icon(Icons.circle, color: Colors.red, size: 12)
                              : null,
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Me'),
                          onTap: () {
                            // Handle selection
                            setState(() {
                              _selectedFilter = "Me";
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == "Me",
                          trailing: _selectedFilter == "Me"
                              ? Icon(Icons.circle, color: Colors.red, size: 12)
                              : null,
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
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = _notifications[index];
          //check notification type and set corresponding icon
          IconData iconData;
          switch (notification['notification type']) {
            case 'Unread':
              iconData = Icons.markunread;
              break;
            case 'All categories':
              iconData = Icons.notifications;
              break;
            case 'Me':
              iconData = Icons.person;
              break;
            case 'Comment':
              iconData = Icons.comment;
              break;
            default:
              iconData = Icons.notifications;
              break;
          }
          return _selectedFilter == "All categories" ||
                  _selectedFilter == notification['notification type']
              ? ListTile(
                  leading: Icon(iconData),
                  title: Text(notification['notificationMessage']),
                  subtitle: Text('Mar 11, 2023 at 15:49'),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
