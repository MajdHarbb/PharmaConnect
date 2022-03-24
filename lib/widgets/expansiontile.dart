import 'package:flutter/material.dart';

class Expansiontile extends StatelessWidget {
  const Expansiontile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: ExpansionTile(
              title: Container(
                child: Row(children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My Account",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Edit Your Profile Information",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              children: [
                ListTile(
                  title: ExpansionTile(
                    title: Container(
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: 30.0,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Account",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Edit Your Profile Information",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    children: [
                      ListTile(
                        title: Text('g'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
