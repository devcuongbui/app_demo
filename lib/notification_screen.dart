import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = "All categories"; // initialize filter value
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchBoardList();
  }

  Future<void> _fetchBoardList() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9/api/getNotifications'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _notifications =
            List<Map<String, dynamic>>.from(jsonDecode(data['Data']));
      });
    } else {
      throw Exception('Failed to load board list');
    }
  }

  List<Map<String, dynamic>> get filteredNotifications {
    switch (_selectedFilter) {
      case 'All categories':
        return _notifications;
      case 'Unread':
        return _notifications
            .where((notification) => notification['NotificationType'] == 1)
            .toList();
      case 'Me':
        return _notifications
            .where((notification) => notification['NotificationType'] == 3)
            .toList();
      case 'Comment':
        return _notifications
            .where((notification) => notification['NotificationType'] == 4)
            .toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
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
                            setState(() {
                              _selectedFilter = 'Unread';
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == 'Unread',
                        ),
                        ListTile(
                          leading: Icon(Icons.category),
                          title: Text('All categories'),
                          onTap: () {
                            setState(() {
                              _selectedFilter = 'All categories';
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == 'All categories',
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Me'),
                          onTap: () {
                            setState(() {
                              _selectedFilter = 'Me';
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == 'Me',
                        ),
                        ListTile(
                          leading: Icon(Icons.comment),
                          title: Text('Comment'),
                          onTap: () {
                            setState(() {
                              _selectedFilter = 'Comment';
                            });
                            Navigator.pop(context);
                          },
                          selected: _selectedFilter == 'Comment',
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
        itemCount: filteredNotifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = filteredNotifications[index];
          IconData iconData;
          switch (notification['NotificationType']) {
            case 1:
              iconData = Icons.markunread;
              break;
            case 2:
              iconData = Icons.notifications;
              break;
            case 3:
              iconData = Icons.person;
              break;
            case 4:
              iconData = Icons.comment;
              break;
            case 0:
              iconData = Icons.notification_important;
              break;
            default:
              iconData = Icons.notification_important;
          }

          return ListTile(
            leading: Icon(iconData),
            title: RichText(
              text: TextSpan(
                text: '${notification['Username']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ${notification['Content']} ',
                  ),
                  TextSpan(
                    text: '${notification['CardName']}',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 36, 24, 23),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' của bảng ',
                  ),
                  TextSpan(
                    text: '${notification['BoardName']}',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 46, 30, 28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              DateFormat("'vào ngày' d 'thg' M',' y 'lúc' HH:mm")
                  .format(DateTime.parse(notification['CreatedDate'])),
            ),
            trailing: Text(""),
            onTap: () {
              //TODO:...
            },
          );
        },
      ),
    );
  }
}
