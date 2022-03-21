import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.grey[200],
                  //backgroundImage: NetworkImage("assets\images\test.jpg"),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pharmacy Name",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "1 hour ago",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                          Icon(
                            Icons.public,
                            color: Colors.grey[600],
                            size: 12.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    print('more');
                  },
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                children: [
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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      print('more');
                    },
                  )
                ]
                
              ),
            
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Logout",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Logout from the current account",
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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      print('more');
                    },
                  )
                ]
                
              ),
              
            ),
             const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About Us",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Read more about PharmaConnect",
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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      print('more');
                    },
                  )
                ]
                
              ),
              
            ),
             const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contact Us",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "Logout from the current account",
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
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      print('more');
                    },
                  )
                ]
                
              ),
              
            ),
          ]
                  // color: Colors.blue[100 * (index % 9 + 1)],
                  // height: 80,
                  // alignment: Alignment.center,
                  // child: Text(
                  //   "Item $index",
                  //   style: const TextStyle(fontSize: 30),
                  // ),
                  ),
        ));
  }
}
