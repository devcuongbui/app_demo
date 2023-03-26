import 'package:demo/create_screen.dart';
import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'notification_screen.dart';
import 'my_cards_screen.dart';
import 'search_screen.dart';
import 'board_screen.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int _currentIndex = 0;
  bool _showAppBar = true;

  final List<Widget> _children = [
    BoardScreen(backgroundImage_add: "5",boardColor_add: "blue",boardName_add: "Công việc mới",checkAdd: false),
    MyCardsScreen(),
    SearchScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _showAppBar = index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              automaticallyImplyLeading: false,
              title: _currentIndex == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 120),
                        Image.asset(
                          'assets/images/trello_logo.png',
                          height: 28,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'My App',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 92),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Text(''),
              actions: [],
            )
          : null,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Boards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'My Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
