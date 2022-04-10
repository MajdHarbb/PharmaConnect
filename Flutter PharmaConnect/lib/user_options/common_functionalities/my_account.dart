import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/widgets/expansiontile.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({ Key? key }) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: const Expansiontile(),
      
    );
  }
}