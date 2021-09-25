import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/home/home_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final _auth = FirebaseAuth.instance;
    var _isLoading = false;
    void _submitAuthForm(String email, String password, String username, bool isLogin, File image, BuildContext ctx) async {

      try{
        setState(() {
          _isLoading = true;
        });

        AuthResult authResult;
        if(isLogin){
          authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
        }else{
          authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          
          final ref = FirebaseStorage.instance.ref().child("userImage").child(authResult.user.uid + ".jpg");
          await ref.putFile(image).onComplete;
          final url = await ref.getDownloadURL();

          Firestore.instance.collection("users").document(authResult.user.uid).setData({
            'username' : username,
            'email' : email,
            'image_url':url,
            "age":"10",
            "exercise":"Very Heavy (> 6 exercises)",
            "gender":"male",
            "height":"0",
            "minutes":"0",
            "weight":"0",
          });
        }

      } on PlatformException catch (err) {
        var message = "An error occures, please check your credentials!";

        if(err.message != null){
          message = err.message;
        }

        Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message), backgroundColor: Theme.of(ctx).errorColor,),);
        setState(() {
          _isLoading = false;
        });

      } catch (err) {
        print(err);
        setState(() {
          _isLoading = false;
        });
      }

    }


    return Scaffold(
      backgroundColor: kLightBlueColor,
      body: HomeForm(_submitAuthForm, _isLoading),
    );
  }
}