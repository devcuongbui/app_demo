import 'package:demo/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'card_detail_screen.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  _MyCardsScreenState createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  bool _filterByDate = true;
  int _cardID = 1;
  DateFormat dateFormat = DateFormat('MMMM dd');
  List<String> _listAvatar = [
    'https://png.pngtree.com/png-vector/20191027/ourlarge/pngtree-cute-pug-avatar-with-a-yellow-background-png-image_1873432.jpg',
    'https://dogily.vn/wp-content/uploads/2022/12/Anh-avatar-cho-Shiba-4.jpg',
    'https://top10camau.vn/wp-content/uploads/2022/10/avatar-meo-cute-5.jpg',
  ];

  Future<List<Map<String, dynamic>>> _fetchCardList() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8010/api/getcards'));
    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body)['Data'];
        final cardData = jsonDecode(data);
        List<dynamic> cardList = [];
        if (cardData is List) {
          cardList = cardData;
        } else if (cardData is Map) {
          cardList = [cardData];
        }
        final resultList = cardList
            .map((board) =>
                Map<String, dynamic>.from(board as Map<String, dynamic>))
            .toList();
        return resultList;
      } catch (e) {
        throw Exception('Failed to decode board list');
      }
    } else {
      throw Exception('Failed to load board list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards'),
        actions: [
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
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchCardList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load card list'),
                    );
                  } else {
                    final cardList = snapshot.data!;
                    return ListView.builder(
                      itemCount: cardList.length,
                      itemBuilder: (context, index) {
                        final card = cardList[index];
                        return _buildCard(
                          card['CardName'],
                          card['LabelColor'],
                          card['DueDate'] != null
                              ? DateTime.parse(card['DueDate'])
                              : null,
                          card['Comment'],
                          card['index_checked'],
                          card['SUM'],
                          _listAvatar,
                          card['CardID'], // pass cardID to _buildCard
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    String title,
    String label,
    DateTime? expirationDate,
    int comments,
    int checkedItems,
    int totalItems,
    List<String> avatars,
    int cardID, // add cardID as a parameter
  ) {
    Color rectangleColor = Colors.blue;
    switch (label.trim()) {
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardsDetailScreen(
                title, cardID), // pass cardID to CardsDetailScreen
          ),
        );
      },
      child: Card(
        key: expirationDate == null
            ? const ValueKey('noExpiration')
            : ValueKey(expirationDate),
        child: ListTile(
          minLeadingWidth: 1,
          leading: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: rectangleColor,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  expirationDate != null
                      ? DateFormat('MMM d').format(expirationDate)
                      : 'No expiration',
                ),
                const SizedBox(width: 8),
                const Icon(Icons.comment_outlined, size: 16),
                const SizedBox(width: 4),
                Text('$comments'),
                const SizedBox(width: 8),
                const Icon(Icons.check_box_outlined, size: 16),
                const SizedBox(width: 4),
                Text('$checkedItems/$totalItems'),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 14,backgroundImage: NetworkImage(avatars[0])),
              const SizedBox(width: 2),
              CircleAvatar(radius: 14,backgroundImage: NetworkImage(avatars[1])),
              const SizedBox(width: 2),
              CircleAvatar(radius: 14,backgroundImage: NetworkImage(avatars[2])),
            ],
          ),
        ),
      ),
    );
  }
}
