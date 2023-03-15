import 'package:demo/checklist_screen.dart';
import 'package:flutter/material.dart';
import 'icon_label.dart';
import 'checklist_screen_show.dart';

class CardsDetailScreen extends StatefulWidget {
  final String cardName;

  CardsDetailScreen(this.cardName);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardName),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List in which this card is contained:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            DropdownButton<String>(
              value: _listName,
              onChanged: (String? newValue) {
                setState(() {
                  _listName = newValue!;
                });
              },
              items: <String>[
                'In Process',
                'Completed',
                'On Hold',
                'Backlog',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                                {'name': 'build base.css', 'isChecked': true},
                                {'name': 'javascript DOM', 'isChecked': false},
                              ],
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.playlist_add),
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
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Expiration Date:',
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
                      lastDate: DateTime.now().add(Duration(days: 365)),
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
                      _member =
                          ''; // Here you can set the default value for the member
                    });
                  },
                  child: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(int index, Map<String, dynamic> item) {
    bool isChecked = item['isChecked'] ?? false;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                item['isChecked'] = value;
              });
            },
          ),
          Text('${index + 1}. ${item['name']}'),
        ],
      ),
    );
  }
}
