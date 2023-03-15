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
    return Scaffold(
      appBar: AppBar(
        title: Text(_checklistName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              _checklistName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            for (final item in _items)
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
          Text('${item['name']}'),
        ],
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
              icon: Icon(Icons.save),
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
