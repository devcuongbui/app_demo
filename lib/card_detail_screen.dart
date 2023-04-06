import 'package:demo/checklist_screen.dart';
import 'package:demo/my_cards_screen.dart';
import 'package:flutter/material.dart';
import 'icon_label.dart';
import 'checklist_screen_show.dart';
import 'comment_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'board_manager.dart';

class CardsDetailScreen extends StatefulWidget {
  final String cardName;
  final int cardID;

  CardsDetailScreen(this.cardName, this.cardID);

  @override
  _CardsDetailScreenState createState() => _CardsDetailScreenState();
}

class _CardsDetailScreenState extends State<CardsDetailScreen> {
  String _listName = 'In Process'; // List within which the card is contained
  String _description = ''; // Description of the card
  DateTime? _expirationDate; // Expiration date of the card
  String _label = 'Label Name'; // Label for the card
  String _member = 'John Doe'; // Member assigned to the card
  String _checklistName = 'test1';
  List<Map<String, dynamic>> _items = [
    {"muc 1": "te"},
    {"muc 1": "te"},
    {"muc 1": "te"},
    {"muc 1": "te"},
    {"muc 1": "te"},
  ];

  List<Color> _labelColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
  ];

  String _comment = "test comment";

  Future<void> _updateCard(int cardID) async {
    final url = Uri.parse('http://10.0.2.2:8010/api/updateCard/$cardID');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'dueDate': _expirationDate?.toIso8601String(),
        'cardID': cardID,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  }

  String getColorName(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.green) {
      return 'Green';
    } else if (color == Colors.blue) {
      return 'Blue';
    } else if (color == Colors.orange) {
      return 'Orange';
    } else if (color == Colors.yellow) {
      return 'Yellow';
    } else {
      // Add more color cases as needed
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? _label = _labelColors[0];
    return GestureDetector(
      // add this widget to detect taps outside TextField
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cardName),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _updateCard(widget.cardID);
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Board(1)),
                  (route) => false, // Xoá tất cả các screen còn lại trên stack
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 80.0),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trong danh sách:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Website bán hàng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        height: 24.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Quick Actions:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChecklistScreenShow(
                                        checklistName: 'Module',
                                        items: [
                                          {
                                            'name': 'build file home.html',
                                            'isChecked': true
                                          },
                                          {
                                            'name': 'build base.css',
                                            'isChecked': true
                                          },
                                          {
                                            'name': 'javascript DOM',
                                            'isChecked': false
                                          },
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.featured_play_list),
                                    Text(
                                      '3/5', // replace with actual values of checked and total items
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                tooltip: 'Add Checklist',
                              ),
                              Text('Checklist'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.attach_file),
                                tooltip: 'Add Attachment',
                              ),
                              Text('Attachment'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.person_add),
                                tooltip: 'Add Member',
                              ),
                              Text('Member'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Chạm để thêm một mô tả',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                          ),
                          Icon(Icons.description),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'DueDate :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _expirationDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                              );
                              if (picked != null) {
                                setState(() {
                                  _expirationDate = picked;
                                });
                              }
                            },
                            child: Text(
                              _expirationDate == null
                                  ? 'Select date'
                                  : 'Date: ${_expirationDate!.toString().split(' ')[0]}',
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _expirationDate = null;
                              });
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Text(
                        'Label Color:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      DropdownButtonFormField<Color>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(),
                        ),
                        value: _label,
                        items: _labelColors.map((color) {
                          return DropdownMenuItem<Color>(
                            value: color,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  getColorName(color),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Color? value) {
                          setState(() {
                            _label = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Assigned Member:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/avatar_user1.jpg',
// Here you can add image that will represent member
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(_member),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/avatar_user2.jpg',
// Here you can add image that will represent the other member
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/avatar_user3.png',
// Here you can add image that will represent the other member
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: Text('Delete Member'),
                                value: 'delete',
                              ),
                            ],
                            onSelected: (String value) {
                              setState(() {
                                _member = '';
                              });
                            },
                            child: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      // CommentSection(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Leave a comment...',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _comment = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
// Add code to submit comment
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
