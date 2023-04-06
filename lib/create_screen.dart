import 'package:demo/board_manager.dart';
import 'package:flutter/material.dart';
import 'board_screen.dart';
import 'background_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with TickerProviderStateMixin {
  late String _boardName = "test";
  late int userID = 1;
  late String _boardColor;
  late String _cardName;
  late String _cardDescription;
  late DateTime _startDate;
  late DateTime _expirationDate;
  late List<String> _members;
  late List<String> _attachments;
  List<String> myStringList = ['string1', 'string2', 'string3'];
  String _backgroundImage = "0";
  // TabController controller = TabController(length: 2, vsync: this);

  Future<void> addBoard() async {
    // get the current user ID or use a default value
    // int userID = currentUser?.id ?? 1;

    // create a new board object with data from form
    BoardModel newBoard = BoardModel(
      boardName: _boardName,
      createdDate: DateTime.now(),
      UserID: 1,
      labels: _backgroundImage,
      labelsColor: _boardColor,
    );

    // call the API to add the new board
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8010/api/addBoard'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newBoard.toJson()),
    );

    // check if the request was successful
    if (response.statusCode == 200) {
      // show success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Board added successfully!')),
      );
    } else {
      // show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding board!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // initialize default values
    _boardColor = 'Blue';
    _members = [];
    _attachments = [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Create'),
              // controller: controller,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Board'),
                  Tab(text: 'Card'),
                ],
              ),
            ),
            body: TabBarView(children: [
              // Board section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Board Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _boardName = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter board name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Board Color',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: _boardColor,
                    items: <String>[
                      'Blue',
                      'Green',
                      'Red',
                      'Yellow',
                      'Custom',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _boardColor = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Background Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DropdownButton<String>(
                    key: UniqueKey(),
                    value: _backgroundImage,
                    onChanged: (value) {
                      setState(() {
                        _backgroundImage = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: '0',
                        child: BackgroundItem(
                          value: 'background_0.jpg',
                          text: 'Background 1',
                          image: 'background_0.jpg',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '1',
                        child: BackgroundItem(
                          value: 'background_1.jpg',
                          text: 'Background 2',
                          image: 'background_1.jpg',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '2',
                        child: BackgroundItem(
                          value: 'background_2.jpg',
                          text: 'Background 3',
                          image: 'background_2.jpg',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '3',
                        child: BackgroundItem(
                          value: 'background_3.jpg',
                          text: 'Background 4',
                          image: 'background_3.jpg',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '4',
                        child: BackgroundItem(
                          value: 'background_4.jpg',
                          text: 'Background 5',
                          image: 'background_4.jpg',
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '9',
                        child: BackgroundItem(
                          value: 'background_9.jpg',
                          text: 'Background 6',
                          image: 'background_9.jpg',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      addBoard();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Board(0)),
                        (route) =>
                            false, // Xoá tất cả các screen còn lại trên stack
                      );
                    },
                    child: Text('Add'),
                  ),
                ],
              ),

              // Card section
              SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          'Card List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          value: null,
                          items: <String>['List 1', 'List 2', 'List 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select a list',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Card Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _cardName = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter card name',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Card Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _cardDescription = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter card description',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Start Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _startDate = DateTime.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter start date',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Expiration Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _expirationDate = DateTime.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter expiration date',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Members',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              myStringList.add(value);
                              _members = myStringList;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter members',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Attachments',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              myStringList.add(value);
                              _attachments = myStringList;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter attachments',
                          ),
                        ),
                      ]))
            ])));
  }
}

class BoardModel {
  final String boardName;
  final String labels;
  final String labelsColor;
  final String createdDate;
  final int UserID;

  BoardModel({
    required this.boardName,
    required this.labels,
    required this.labelsColor,
    DateTime? createdDate,
    required this.UserID,
  }) : createdDate = createdDate?.toIso8601String() ?? '';

  Map<String, dynamic> toJson() => {
        'BoardName': boardName,
        'Labels': labels,
        'LabelsColor': labelsColor,
        'CreatedDate': createdDate,
        'UserID': UserID,
      };
}
