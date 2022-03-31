import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us, !'),
      ),
      body: SafeArea(
        child: Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Send Us A Message',
                style: TextStyle(fontSize: 25),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),]),
                child: Form(
                  child: TextFormField(
                    
                    keyboardType: TextInputType.multiline,
                    minLines: 5,//Normal textInputField will be displayed
                    maxLines: 5,
                    decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.message_rounded),
                    border: OutlineInputBorder(),
                    labelText: 'Your Message Text Here...',),
                                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
