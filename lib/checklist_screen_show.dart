import 'package:flutter/material.dart';

class ChecklistScreenShow extends StatefulWidget {
  final String checklistName;
  final List<Map<String, dynamic>> items;

  ChecklistScreenShow({
    required this.checklistName,
    required this.items,
  });

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreenShow> {
  final _items = <Map<String, dynamic>>[];
  final _itemNameController = TextEditingController();
  final _itemNameFocusNode = FocusNode();
  bool _isAddingNewItem = false;
  String _checklistName = '';
  bool _isEditingName = false;
  bool? _isCheckedFilter = null;

  @override
  void initState() {
    super.initState();
    _items.addAll(widget.items);
    _checklistName = widget.checklistName;
    _isAddingNewItem = false;
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// Define a variable to store the filtered items
    List<Map<String, dynamic>> filteredItems = [];
    if (_isCheckedFilter == true) {
      filteredItems = _items
          .where((item) => item['isChecked'])
          .toList(); // displays checked items only
    } else if (_isCheckedFilter == false) {
      filteredItems = _items
          .where((item) => !item['isChecked'])
          .toList(); // displays unchecked items only
    } else {
      filteredItems = List.from(_items); // displays all items
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

  Widget _buildChecklistItem(int index, Map<String, dynamic> item) {
    bool isChecked = item['isChecked'] ?? false;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            item['isEditable'] = true;
          });
        },
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
            Expanded(
              child: item['isEditable'] == true
                  ? Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: item['name'],
                            autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                item['name'] = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              item['isEditable'] = false;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _items.removeAt(index);
                            });
                          },
                        ),
                      ],
                    )
                  : Text(
                      '${item['name']}',
                      style: isChecked
                          ? TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : TextStyle(),
                    ),
            ),
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
                  _addItem(value);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                _addItem(_itemNameController.text);
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

  void _addItem(String itemName) {
    if (itemName.isNotEmpty) {
      setState(() {
        _items.add({'name': itemName, 'isChecked': false});
        _itemNameController.clear();
        _isAddingNewItem = false;
        _itemNameFocusNode.unfocus();
      });
      // Scroll to the added item
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final double distance =
            box.size.height - box.localToGlobal(Offset.zero).dy;
        if (distance > 0) {
          Scrollable.ensureVisible(context,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        }
      });
    }
  }
}
