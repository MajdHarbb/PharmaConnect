import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({ Key? key }) : super(key: key);

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
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                    "@useremail",
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
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {
                            print('more');
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        'assets/images/aspirin.jpg',
                        width: 600.0,
                        height: 240.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            print("test");
                          },
                          label: const Text(
                            'View',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            print("test");
                          },
                          label: const Text(
                            'Call',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            print("test");
                          },
                          label: const Text(
                            'Share',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                      ],
                    )
                  ],
                  // color: Colors.blue[100 * (index % 9 + 1)],
                  // height: 80,
                  // alignment: Alignment.center,
                  // child: Text(
                  //   "Item $index",
                  //   style: const TextStyle(fontSize: 30),
                  // ),
                ),
              ),
     
    );
  }
}