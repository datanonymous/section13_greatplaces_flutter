import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      //can add showDialog for error handling
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  //transferred from image_input.dart
  File _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
    await File(imageFile.path).copy('${appDir.path}/$fileName');
//    widget.onSelectImage(savedImage); //execute function _selectImage and pass savedImage to it
    _selectImage(savedImage); //setting the savedImage to _pickedImage; _savePlace needs a _pickedImage to not be null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),

                    //////////////////////////////////////////
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _storedImage != null
                              ? Image.file(
                            _storedImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                              : Text(
                            'No image taken',
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            onPressed: _takePicture,
                            icon: Icon(Icons.camera),
                            label: Text('Take picture'),
                            textColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    //////////////////////////////////////////

                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(
              Icons.add,
            ),
            label: Text('Add place'),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}

