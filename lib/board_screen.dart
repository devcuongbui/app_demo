import 'package:demo/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'create_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late Future<List<Map<String, dynamic>>> _boardListFuture;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _boardListFuture = _fetchBoardList();
  }

  Future<List<Map<String, dynamic>>> _fetchBoardList() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8010/api/getboards'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from([jsonDecode(response.body)])
          .toList();
    } else {
      throw Exception('Failed to load board list');
    }
  }

  Color _getLabelColor(String label) {
    switch (label.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'white':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  AssetImage _getImageLabel(String imagePath) {
    return AssetImage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter board name',
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
              future: _boardListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading data'));
                } else {
                  List<Map<String, dynamic>> boardList = snapshot.data!;
                  String boardName = boardList[0]["Data"];
                  List<Map<String, dynamic>> mapList =
                      List<Map<String, dynamic>>.from(jsonDecode(boardName));
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      Color labelColor =
                          _getLabelColor(mapList[index]['LabelsColor']);
                      // Set the same color for the label and bottom container
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen(
                                    BoardName: 'Công việc ở công ty')),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          // add image to the label and bottom container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _getImageLabel(
                                        'assets/images/background/background_${mapList[index]['Labels']}.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                            color: labelColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        Text(
                                          mapList[index]['BoardName']
                                              .replaceAll("_", "-"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      mapList[index]['CreatedDate']
                                          .substring(0, 10),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16);
                    },
                    itemCount: mapList.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
