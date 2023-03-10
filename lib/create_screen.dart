import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with TickerProviderStateMixin {
  late String _boardName;
  late String _boardColor;
  late String _cardName;
  late String _cardDescription;
  late DateTime _startDate;
  late DateTime _expirationDate;
  late List<String> _members;
  late List<String> _attachments;
  List<String> myStringList = ['string1', 'string2', 'string3'];
  // TabController controller = TabController(length: 2, vsync: this);

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
                    items: <String>['Blue', 'Green', 'Red', 'Yellow']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _boardColor = value!;
                      });
                    },
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
