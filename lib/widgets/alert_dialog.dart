import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertComponent{
  final String title;
  final String message;
  final GestureTapCallback onpress;
  AlertComponent({required this.title,required this.message,required this.onpress});
  Widget AlertBox(){
    return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          onpress==null?Container():TextButton(
            child: const Text('ok'),
            onPressed: onpress,
          )
        ]);
  }
}