import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/add_place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        children: [
          Text('User inputs...'),
          RaisedButton.icon(
            icon: Icon(
              Icons.add,
            ),
            label: Text('Add place'),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
