import 'dart:io';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/home/user_image_picker.dart';
import 'package:flutter/material.dart';

class HomeForm extends StatefulWidget {
  final void Function(String email, String password, String username, bool isLogin, File image, BuildContext ctx) submitForm;
  final bool isLoading;
  HomeForm(this.submitForm, this.isLoading);

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  File _userImageFile;

  void _pickedImage(File image){
    _userImageFile = image;
  }


  void _trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please pick an image."), backgroundColor: Theme.of(context).errorColor,));
      return;
    }

    if(isValid){
      _formKey.currentState.save();
      widget.submitForm(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        _userImageFile,
        context,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Fitness App", 
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: kLightBlueColor,
                    ),
                  ),
                  SizedBox(height: 15),

                  if(!_isLogin)
                  UserImagePicker(_pickedImage),

                  TextFormField(
                    key:ValueKey("Email"),
                    decoration: InputDecoration(
                      hintText: "Email Address",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val){
                      if(val.isEmpty || !val.contains("@")){
                        return "Please enter a valid email address.";
                      }
                      return null;
                    },
                    onSaved: (val){
                      _userEmail = val;
                    },
                  ),
                
                  if(!_isLogin)
                  TextFormField(
                    key:ValueKey("Username"),
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                    validator: (val){
                      if(val.isEmpty || val.length < 5){
                        return "Please enter at least 5 characters.";
                      }
                      return null;
                    },
                    onSaved: (val){
                      _userName = val;
                    },
                  ),

                  TextFormField(
                    key:ValueKey("Password"),
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    obscureText: true,
                    validator: (val){
                      if(val.isEmpty || val.length < 7){
                        return "Password must be at least 7 characters long.";
                      }
                      return null;
                    },
                    onSaved: (val){
                      _userPassword = val;
                    },
                  ),

                  SizedBox(height: 15,),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                  RaisedButton(
                    child: Text( _isLogin ? "Login" : "Register", style: TextStyle(color:kWhiteColor)),
                    color: kLightBlueColor,
                    onPressed: _trySubmit,
                  ),

                  if(!widget.isLoading)
                  FlatButton(
                    child: Text(_isLogin ? "Create new account" : "I already have an account"),
                    textColor: kLightBlueColor,
                    onPressed: (){
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}