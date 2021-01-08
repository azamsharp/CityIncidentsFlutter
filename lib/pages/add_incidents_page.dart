import 'dart:io';

import 'package:city_care/models/incident.dart';
import 'package:city_care/view_models/add_incident_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum PhotoOptions { camera, library }

class AddIncidentsPage extends StatefulWidget {
  @override
  _AddIncidentsPage createState() => _AddIncidentsPage();
}

class _AddIncidentsPage extends State<AddIncidentsPage> {
  
  File _image;
  final _formKey = GlobalKey<FormState>();
  AddIncidentViewModel _addIncidentVM; 

  final _titleController = TextEditingController(); 
  final _descriptionController = TextEditingController(); 

  void _selectPhotoFromPhotoLibrary() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _selectPhotoFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _optionSelected(PhotoOptions option) {
    switch (option) {
      case PhotoOptions.camera:
        _selectPhotoFromCamera();
        break;
      case PhotoOptions.library:
        _selectPhotoFromPhotoLibrary();
        break;
    }
  }

  void _saveIncident(BuildContext context) async {

    final userId = FirebaseAuth.instance.currentUser.uid; 

    // validate the form
    if (_formKey.currentState.validate()) {
      // upload the photo to the Firebase storage
      final filePath = await _addIncidentVM.uploadFile(_image);
      if(filePath.isNotEmpty) {
        
        final title = _titleController.text; 
        final description = _descriptionController.text; 

        // save the incident in the Firestore database 
        final incident = Incident(userId: userId, title: title, description: description, photoURL: filePath, incidentDate: DateTime.now()); 
        final isSaved = await _addIncidentVM.saveIncident(incident); 
        if(isSaved) {
          // close the modal 
          Navigator.pop(context, true); 
        }

      }
    }

  }

  Widget _buildLoadingWidget() {
    switch(_addIncidentVM.loadingStatus) {
      case LoadingState.loading:   
        return CircularProgressIndicator(); 
      default: 
        return SizedBox.shrink(); 
    }
  }

  @override
  Widget build(BuildContext context) {

    _addIncidentVM = Provider.of<AddIncidentViewModel>(context); 

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Incident"), 
          
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    child: _image == null ? Image.asset("assets/images/city_care.jpg") : Image.asset(_image.path), 
                    width: 300, 
                    height: 300
                  ),
                 Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {},
                      textColor: Colors.white,
                      child: PopupMenuButton<PhotoOptions>(
                        child: Text("Add Photo"),
                        onSelected: _optionSelected,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Take a picture"),
                            value: PhotoOptions.camera,
                          ),
                          PopupMenuItem(
                              child: Text("Select from photo library"),
                              value: PhotoOptions.library)
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _titleController, 
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Title is required!";
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(hintText: "Enter incident title"),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Description is required!";
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration:
                        InputDecoration(hintText: "Enter incident description"),
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _saveIncident(context);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ), 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_addIncidentVM.message),
                  ), 
                  _buildLoadingWidget() 
                ]),
              ),
            ),
          ),
        ));
  }
}
