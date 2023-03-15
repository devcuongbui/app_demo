import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final _items = <Map<String, dynamic>>[];
  final _itemNameController = TextEditingController();
  final _itemNameFocusNode = FocusNode();
  bool _isAddingNewItem = false;
  String _checklistName = '';

  @override
  void initState() {
    super.initState();
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
        title: Text('Checklist Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Checklist Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _checklistName),
                onChanged: (value) {
                  _checklistName = value;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Checklist Items:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              for (final item in _items)
                _buildChecklistItem(_items.indexOf(item), item),
              _isAddingNewItem ? _buildNewItemRow() : _buildAddNewItemRow(),
            ],
          ),
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
          Text('$index. ${item['name']}'),
        ],
      ),
    );
  }

  Widget _buildAddNewItemRow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAddingNewItem = true;
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
    return Row(
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
            });
          },
        ),
      ],
    );
  }

  void _addItem(String itemName) {
    if (itemName.isNotEmpty) {
      setState(() {
        _items.add({'name': itemName, 'isChecked': false});
        _itemNameController.clear();
        _isAddingNewItem = false;
      });
    }
  }
}
