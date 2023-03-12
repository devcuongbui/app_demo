import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  final String BoardName;

  const ListScreen({Key? key, required this.BoardName}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _filterByDate = true;
  DateFormat dateFormat = DateFormat('MMMM dd');
  List<String> _listAvatar = [
    'https://png.pngtree.com/png-vector/20191027/ourlarge/pngtree-cute-pug-avatar-with-a-yellow-background-png-image_1873432.jpg',
    'https://dogily.vn/wp-content/uploads/2022/12/Anh-avatar-cho-Shiba-4.jpg',
    'https://top10camau.vn/wp-content/uploads/2022/10/avatar-meo-cute-5.jpg',
  ];
  final Map<String, List<Map<String, dynamic>>> _cardLists = {
    'Website bán hàng': [
      {
        'CardName': 'FrontEnd',
        'Label': 'Medium',
        'ExpirationDate': '2023-12-31',
        'Comments': 4,
        'CheckedItems': 3,
        'TotalItems': 5,
      },
      {
        'CardName': 'Create Database',
        'Label': 'Low',
        'ExpirationDate': '2024-06-30',
        'Comments': 3,
        'CheckedItems': 2,
        'TotalItems': 5,
      },
      {
        'CardName': 'Create WebAPI',
        'Label': 'High',
        'ExpirationDate': '2024-06-30',
        'Comments': 5,
        'CheckedItems': 2,
        'TotalItems': 4,
      },
      {
        'CardName': 'BackEnd',
        'Label': 'High',
        'ExpirationDate': '2024-06-30',
        'Comments': 11,
        'CheckedItems': 3,
        'TotalItems': 4,
      },
// ... more cards
    ],
    'Phần mềm quản lý công nhân': [
      {
        'CardName': 'Card 6',
        'Label': 'Medium',
        'ExpirationDate': '2022-09-30',
        'Comments': 11,
        'CheckedItems': 1,
        'TotalItems': 3,
      },
// ... more cards
    ],
    'App mobile quản lý công việc cá nhân': [
      {
        'CardName': 'Card 11',
        'Label': 'High',
        'ExpirationDate': '2023-04-30',
        'Comments': 4,
        'CheckedItems': 0,
        'TotalItems': 2,
      },
// ... more cards
    ],
    '': [], // empty list to add new list
  };

  int _currentPage = 0;

  Widget build(BuildContext context) {
    List<String> listNames = _cardLists.keys.toList();
    bool sortByIncreasing =
        true; // Default option is to sort by increasing expiration date

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.BoardName),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Sort by increasing expiration date"),
                  value: true,
                ),
                PopupMenuItem(
                  child: Text("Sort by decreasing expiration date"),
                  value: false,
                ),
              ];
            },
            onSelected: (value) {
              setState(() {
                sortByIncreasing = value;
              });
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the form to add a new list.
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                String listName = listNames[index];
                List<Map<String, dynamic>> cardList =
                    _cardLists.values.toList()[index];
                return _buildCardsList(listName, cardList);
              },
              itemCount: _cardLists.length,
              controller: PageController(initialPage: _currentPage),
            ),
          ),
          if (_cardLists.isEmpty)
            ElevatedButton(
              onPressed: () {
                // Navigate to the form to add a new list.
              },
              child: Text('Add New List'),
            ),
          SizedBox(
            height: 48,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: _currentPage == index
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                            size: 12,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromLabel(String label) {
    switch (label) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getFormattedExpirationDate(DateTime? expirationDate) {
    if (expirationDate == null) {
      return 'No date';
    } else {
      final formatter = DateFormat('MMM d, y');
      return formatter.format(expirationDate);
    }
  }

  Widget _buildCardsList(String listName, List<Map<String, dynamic>> cardList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              String title = cardList[index]['CardName'];
              String label = cardList[index]['Label'];
              DateTime? expirationDate =
                  DateTime.tryParse(cardList[index]['ExpirationDate'] ?? '');
              int comments = cardList[index]['Comments'];
              int checkedItems = cardList[index]['CheckedItems'];
              int totalItems = cardList[index]['TotalItems'];
              List<String> avatars = List.castFrom<dynamic, String>(
                  cardList[index]['Avatars'] ?? []);
              return _buildCard(
                title,
                label,
                expirationDate,
                comments,
                checkedItems,
                totalItems,
                avatars,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(width: 16),
            itemCount: cardList.length,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String label, DateTime? expirationDate,
      int comments, int checkedItems, int totalItems, List<String> avatars) {
    return GestureDetector(
      onTap: () {
        // Handle item click
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _getColorFromLabel(label),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(
                    _getFormattedExpirationDate(expirationDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.comment,
                    size: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(
                    comments.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    checkedItems == totalItems
                        ? Icons.check_circle_outline
                        : Icons.check_circle_outline_rounded,
                    size: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$checkedItems/$totalItems',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: List.generate(
                  avatars.length,
                  (index) => CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(avatars[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
