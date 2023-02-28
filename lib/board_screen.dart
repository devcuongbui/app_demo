import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<Map<String, dynamic>> _boardList = [
    {
      'name': 'Board 1',
      'creator': 'John Doe',
      'dateCreated': '2022-02-14',
      'expirationDate': '2022-03-14',
    },
    {
      'name': 'Board 2',
      'creator': 'Jane Smith',
      'dateCreated': '2022-02-15',
      'expirationDate': '2022-03-15',
    },
    {
      'name': 'Board 3',
      'creator': 'Bob Johnson',
      'dateCreated': '2022-02-16',
      'expirationDate': '2022-03-16',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _boardList[index]['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Created by ${_boardList[index]['creator']} on ${_boardList[index]['dateCreated']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Expires on ${_boardList[index]['expirationDate']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                height: 1,
                thickness: 1,
                indent: 24,
                endIndent: 24,
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey[300],
            height: 1,
            thickness: 1,
            indent: 24,
            endIndent: 24,
          );
        },
        itemCount: _boardList.length,
      ),
    );
  }
}
