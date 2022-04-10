import 'package:flutter/material.dart';

class Utility{

  static Utility? utility;

  static Utility? getInstance(){
    utility ??= Utility();
    return utility;
  }

  showAlertDialog(BuildContext context, String alertTitle, String alertMessage){
    // set up the buttons
    Widget cancelButton = TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            );
            
    Widget continueButton = TextButton(
              onPressed: () =>  Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(alertMessage)
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

}