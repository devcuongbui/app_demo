import 'package:demo/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  _MyCardsScreenState createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  bool _filterByDate = true;
  DateFormat dateFormat = DateFormat('MMMM dd');
  List<String> _listAvatar = [
    'https://png.pngtree.com/png-vector/20191027/ourlarge/pngtree-cute-pug-avatar-with-a-yellow-background-png-image_1873432.jpg',
    'https://dogily.vn/wp-content/uploads/2022/12/Anh-avatar-cho-Shiba-4.jpg',
    'https://top10camau.vn/wp-content/uploads/2022/10/avatar-meo-cute-5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Implement search function
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.filter_alt_outlined),
                SizedBox(width: 8),
                DropdownButton<bool>(
                  value: _filterByDate,
                  onChanged: (value) {
                    setState(() {
                      _filterByDate = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Expiration Date'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Board'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter card name',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildCardsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList() {
    List<Widget> cards = [
      _buildCard('Card 1', 'green', DateTime.now().add(Duration(days: 3)), 2, 1,
          3, _listAvatar),
      _buildCard('Card 2', 'red', DateTime.now().add(Duration(days: 2)), 4, 5,
          10, _listAvatar),
      _buildCard('Card 3', 'yellow', DateTime.now().add(Duration(days: 2)), 4,
          7, 10, _listAvatar),
      _buildCard('Card 4', 'blue', DateTime.now().add(Duration(days: 2)), 4, 9,
          10, _listAvatar)
    ];

    if (_filterByDate) {
      cards =
          cards.where((card) => card.key != ValueKey('noExpiration')).toList();
    }

    return ListView(children: cards);
  }

  Widget _buildCard(String title, String label, DateTime? expirationDate,
      int comments, int checkedItems, int totalItems, List<String> avatars) {
    Color rectangleColor = Colors.blue;
    switch (label) {
      case 'green':
        rectangleColor = Colors.green;
        break;
      case 'red':
        rectangleColor = Colors.red;
        break;
      case 'yellow':
        rectangleColor = Colors.yellow;
        break;
      default:
        rectangleColor = Colors.blue;
    }

    return Card(
      key: expirationDate == null
          ? ValueKey('noExpiration')
          : ValueKey(expirationDate),
      child: ListTile(
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: rectangleColor,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
        ),
        title: Text(title),
        subtitle: Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 16),
            SizedBox(width: 4),
            Text(
              expirationDate != null
                  ? DateFormat('MMM d').format(expirationDate)
                  : 'No expiration',
            ),
            SizedBox(width: 8),
            Icon(Icons.comment_outlined, size: 16),
            SizedBox(width: 4),
            Text('$comments'),
            SizedBox(width: 8),
            Icon(Icons.check_box_outlined, size: 16),
            SizedBox(width: 4),
            Text('$checkedItems/$totalItems'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatars[0])),
            SizedBox(width: 4),
            CircleAvatar(backgroundImage: NetworkImage(avatars[1])),
            SizedBox(width: 4),
            CircleAvatar(backgroundImage: NetworkImage(avatars[2])),
          ],
        ),
      ),
    );
  }
}
