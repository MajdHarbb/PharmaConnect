import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }

class PatientPharmacies extends StatefulWidget {
  const PatientPharmacies({Key? key}) : super(key: key);

  @override
  _PatientPharmaciesState createState() => _PatientPharmaciesState();
}

class _PatientPharmaciesState extends State<PatientPharmacies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        // const SliverAppBar(
        //   backgroundColor: Colors.amber,
        //   title: Text('Kindacode.com'),
        //   expandedHeight: 30,
        //   collapsedHeight: 150,
        // ),
        const SliverAppBar(
          //backgroundColor: Colors.green,
          title: Text('Pharmacies'),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return Container(
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
                              const Text("Pharmacy Name", style:
                              TextStyle(fontWeight: FontWeight.w600)
                              ,),
                              Row(
                                children:  [
                                  Text("1 hour ago", 
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                    ),),
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
                                  onPressed: () {print('more');} ,
                                )
                      ],
                    ),
                  ],
                  // color: Colors.blue[100 * (index % 9 + 1)],
                  // height: 80,
                  // alignment: Alignment.center,
                  // child: Text(
                  //   "Item $index",
                  //   style: const TextStyle(fontSize: 30),
                  // ),
                ),
              );
            },
            childCount: 5, // 1000 list items
          ),
        ),
      ],
    ));
  }
}
