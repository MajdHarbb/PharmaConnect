import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/widgets/expansionTile.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({Key? key}) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expansiontile(),
            Container(
              padding: const EdgeInsets.all(8.0),
                color: Colors.white,
              child: ExpansionTile(
                title: Row(children: [
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
                children: [
                  ListTile(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
