import 'package:demo/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'create_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'board_manager.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  String _searchKeyword = 'c';
  late Future<List<Map<String, dynamic>>> _boardListFuture;
  List<Map<String, dynamic>> _searchResult = [];
  @override
  void initState() {
    super.initState();
    _boardListFuture = _fetchBoardList();
  }

  Future<List<Map<String, dynamic>>> _fetchBoardList() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8010/api/getboards'));
    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body)['Data'];
        final boardData = jsonDecode(data);
        List<dynamic> boardList = [];
        if (boardData is List) {
          boardList = boardData;
        } else if (boardData is Map) {
          boardList = [boardData];
        }
        final resultList = boardList
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

  Future<List<Map<String, dynamic>>> _searchBoards(String keyword) async {
    final url = Uri.parse('http://10.0.2.2:8010/api/searchBoards/$keyword');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<Map<String, dynamic>> boardList =
          (jsonData['Data'] as List).cast<Map<String, dynamic>>();
      return boardList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _deleteBoard(int boardId) async {
    final url = Uri.parse('http://10.0.2.2:8010/api/deleteBoard/$boardId');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
// Success
      print('Board deleted successfully');
    } else {
// Error
      print('Failed to delete board. Error: ${response.reasonPhrase}');
    }
  }

  void _onSearch(String keyword) async {
    if (keyword.isNotEmpty) {
      final result = await _searchBoards(keyword);
      setState(() {
        _searchKeyword = keyword;
        _searchResult = result;
      });
    } else {
      setState(() {
        _searchKeyword = '';
        _searchResult = [];
      });
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
              onChanged: (value) => _onSearch(value),
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
              future: _searchBoards(_searchKeyword),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading data'));
                } else {
                  List<Map<String, dynamic>> boardList = snapshot.data!;
                  List<Map<String, dynamic>> mapList = boardList;
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      // Build the board item widget
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListScreen(
                                BoardName: 'Công việc ở công ty',
                              ),
                            ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Add image to the label and bottom container
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _getImageLabel(
                                      'assets/images/background/background_${mapList[index]['Labels']}.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirm'),
                                            content: Text(
                                              'Are you sure you want to delete this board?',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Delete'),
                                                onPressed: () async {
                                                  // TODO: delete board
                                                  await _deleteBoard(index +
                                                      1); // call _deleteBoard function
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Board(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
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
                                            color: _getLabelColor(
                                              mapList[index]['LabelsColor'],
                                            ),
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
