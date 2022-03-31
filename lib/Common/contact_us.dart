import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  String user_id = "";
  String access_Token = "";

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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        minLines: 5, //Normal textInputField will be displayed
                        maxLines: 5,
                        controller: messageController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.message_rounded),
                          border: OutlineInputBorder(),
                          labelText: 'Your Message Text Here...',
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await http.post(
                                Uri.parse(
                                    'http://192.168.0.117:8000/api/user/send-message'),
                                headers: {
                                  'Authorization': 'Bearer $access_Token',
                                },
                                body: {
                                  'user_id': user_id,
                                  'message_text': messageController.text,
                                },
                              );

                              if (response.statusCode == 201) {
                                // If the server did return a 201 CREATED response,
                                // then parse the JSON.
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                        'Thank You! We Received Your Message.'),
                                    content: const Text(
                                        'Press okay to return to your screen'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // If the server did not return a 201 CREATED response,
                                // then throw an exception.
                                print(response.body);
                              }
                            }
                          },
                          child: const Text('Send Message'),
                        ),
                        const Icon(
                          Icons.send_rounded,
                          color: Colors.blue,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    getStringValuesSF();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('accesToken');

    setState(() {
      user_id = prefs.getString('id')!;
      access_Token = prefs.getString('accesToken')!;
    });
  }
}
