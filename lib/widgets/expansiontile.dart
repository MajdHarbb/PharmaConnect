import 'package:flutter/material.dart';

class Expansiontile extends StatefulWidget {
  const Expansiontile({Key? key}) : super(key: key);

  @override
  State<Expansiontile> createState() => _ExpansiontileState();
}

class _ExpansiontileState extends State<Expansiontile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: ExpansionTile(
                    title: Column(
                      children: 
                        [Row(children: [
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
                                  "Edit Name",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Enter Your Name here: ",
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
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Container(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.text_fields_rounded),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter your new name"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter your password"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                          
                                        ),
                                        hintText: "Confirm your password"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('save')),
                              ],
                            ),
                          ],
                        ),
                        ),
                      ),
                    ],
                  ),

          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: ExpansionTile(
                    title: Column(
                      children: 
                        [Row(children: [
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
                                  "Edit Name",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Enter Your Name here: ",
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
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Container(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.text_fields_rounded),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter your new name"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter your password"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    //controller: postTextController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                          
                                        ),
                                        hintText: "Confirm your password"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('save')),
                              ],
                            ),
                          ],
                        ),
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
