import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChecklistScreenShow extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreenShow> {
  final String checklistTitle = "null";
  final String title = "null";

  final List<ChecklistItem> _items = <ChecklistItem>[];
  final _itemNameController = TextEditingController();
  final _itemNameFocusNode = FocusNode();
  bool _isAddingNewItem = false;
  String _checklistName = '';
  bool _isEditingName = false;
  bool? _isCheckedFilter = null;

  @override
  void initState() {
    super.initState();
    _fetchChecklistItems(); // Thay vì addAll ở đây, gọi hàm lấy dữ liệu từ API
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemNameFocusNode.dispose();
    super.dispose();
  }

  ChecklistItem _createChecklistItemFromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      checklistTitle: json['ChecklistTitle'],
      title: json['Title'],
    );
  }

  Future<void> _fetchChecklistItems() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8010/api/getChecklists'));
    final jsonList = json.decode(response.body)['Data'];

    final List<ChecklistItem> items =
        jsonList.map((json) => _createChecklistItemFromJson(json)).toList();

    setState(() {
      _checklistName =
          jsonList[0]['ChecklistTitle']; // Lấy tên danh sách kiểm tra từ API
      _items.addAll(items); // Thêm các mục kiểm tra từ API vào danh sách
    });
  }

  @override
  Widget build(BuildContext context) {
// Define a variable to store the filtered items
    List<ChecklistItem> filteredItems = [];
    if (_isCheckedFilter == true) {
      filteredItems = _items
          .where((item) => item.isChecked)
          .toList(); // Hiển thị các mục đã đánh dấu
    } else if (_isCheckedFilter == false) {
      filteredItems = _items
          .where((item) => !item.isChecked)
          .toList(); // Hiển thị các mục chưa đánh dấu
    } else {
      filteredItems = List.from(_items); // Hiển thị tất cả các mục
    }
    return Scaffold(
      appBar: AppBar(
// Display the checklist name as text or as an editable text field
        title: _isEditingName
            ? TextFormField(
                initialValue: _checklistName,
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _checklistName = value;
                  });
                },
              )
            : Text(_checklistName),
        actions: [
// Toggle between displaying the checklist name as text and as an editable text field
          IconButton(
            icon: _isEditingName ? Icon(Icons.check) : Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditingName = !_isEditingName;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                _isCheckedFilter = false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () {
              setState(() {
                _isCheckedFilter = true;
              });
            },
          ),
// Toggle between filtering and displaying only checked items, only unchecked items, or all items
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              setState(() {
                _isCheckedFilter = null;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
// Display the checklist name as text
            if (!_isEditingName)
              Text(
                _checklistName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            SizedBox(height: 8.0),
// Display the items based on the selected filter option
            for (final item in filteredItems)
              _buildChecklistItem(_items.indexOf(item), item),
            SizedBox(height: 16.0),
            _buildAddNewItemRow(),
            if (_isAddingNewItem) _buildNewItemRow(),
            SizedBox(height: 64.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      {
                        'checklistName': _checklistName,
                        'items': _items,
                      },
                    );
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(int index, ChecklistItem item) {
    bool isChecked = item.isChecked ?? false;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // item.isEditable = true;
          });
        },
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  // item.isChecked = value;
                });
              },
            ),
            // Expanded(
            //   child: item.isEditable == true
            //       ? Row(
            //           children: [
            //             Expanded(
            //               child: TextFormField(
            //                 initialValue: item.title,
            //                 autofocus: true,
            //                 onChanged: (value) {
            //                   setState(() {
            //                     item.title = value;
            //                   });
            //                 },
            //               ),
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.done),
            //               onPressed: () {
            //                 setState(() {
            //                   // item.isEditable = false;
            //                 });
            //               },
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.delete),
            //               onPressed: () {
            //                 setState(() {
            //                   _items.removeAt(index);
            //                 });
            //               },
            //             ),
            //           ],
            //         )
            //       : Text(
            //           '${item.title}',
            //           style: isChecked
            //               ? TextStyle(
            //                   decoration: TextDecoration.lineThrough,
            //                 )
            //               : TextStyle(),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewItemRow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAddingNewItem = true;
          _itemNameFocusNode.requestFocus();
        });
      },
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 8.0),
          Text('Add an item'),
        ],
      ),
    );
  }

  Widget _buildNewItemRow() {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                  hintText: 'Enter item name',
                ),
                controller: _itemNameController,
                focusNode: _itemNameFocusNode,
                autofocus: true,
                onSubmitted: (value) {
                  // _addItem(value);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                // _addItem(_itemNameController.text);
              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isAddingNewItem = false;
                  _itemNameController.clear();
                  _itemNameFocusNode.unfocus();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

//   void _addItem(String itemName) {
//     if (itemName.isNotEmpty) {
//       setState(() {
//         _items.add(ChecklistItem(title: itemName));
//         _itemNameController.clear();
//         _isAddingNewItem = false;
//         _itemNameFocusNode.unfocus();
//       });
//       // Scroll to the added item
//       WidgetsBinding.instance?.addPostFrameCallback((_) {
//         final RenderBox box = context.findRenderObject() as RenderBox;
//         final double distance =
//             box.size.height - box.localToGlobal(Offset.zero).dy;
//         if (distance > 0) {
//           Scrollable.ensureVisible(context,
//               duration: Duration(milliseconds: 500), curve: Curves.easeIn);
//         }
//       });
//     }
//   }
// }
}

class ChecklistItem {
  String checklistTitle;
  String title;
  bool _isChecked;

  ChecklistItem(
      {required this.checklistTitle,
      required this.title,
      bool isChecked = false})
      : _isChecked = isChecked;

  bool get isChecked => _isChecked;
  set isChecked(bool value) => _isChecked = value;
}
