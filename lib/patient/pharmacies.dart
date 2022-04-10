import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmaconnectflutter/map/map_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class PatientPharmacies extends StatefulWidget {
  const PatientPharmacies({Key? key}) : super(key: key);

  @override
  _PatientPharmaciesState createState() => _PatientPharmaciesState();
}

class _PatientPharmaciesState extends State<PatientPharmacies> {
  @override
  // The list that contains list of pharmacies
  List _pharmaciesList = [];
  String access_Token = "";
  String pharmacy_profile_pic = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Pharmacies'),
          floating: true,
          leading: Icon(
            Icons.storefront_outlined,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                    ),
                  ],
                ),
                //color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(
                              'http://192.168.0.117:8000/profiles/${_pharmaciesList[index]["profile_pic"]}'),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _pharmaciesList[index]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'member since ${_pharmaciesList[index]["updated_at"].substring(0, _pharmaciesList[index]["updated_at"].indexOf('T'))}',
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
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                        '${_pharmaciesList[index]["building"]}, ${_pharmaciesList[index]["street"]}'),
                    Text('${_pharmaciesList[index]["district"]}'),
                    Text('${_pharmaciesList[index]["locality"]}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            MapUtils.openMap(_pharmaciesList[index]["latitude"],
                                _pharmaciesList[index]["longitude"]);
                          },
                          label: const Text(
                            'Maps',
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
                            MapUtils.openDialer(
                                '${_pharmaciesList[index]["phone"]}');
                          },
                          label: const Text(
                            'Call',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.email_rounded,
                            color: Colors.blue,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(10, 40),
                            primary: Colors.white,
                          ),

                          onPressed: () {
                            MapUtils.openMail(
                                '${_pharmaciesList[index]["email"]}');
                          },
                          label: const Text(
                            'Email',
                            style: TextStyle(color: Colors.black),
                          ),
                          //controller: streetController,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            childCount: _pharmaciesList.length,
            // 1000 list items
          ),
        ),
      ],
    ));
  }

  // The function that fetches data from the API
  Future<void> _fetchPharmaciesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    setState(() {
      access_Token = prefs.getString('accesToken')!;
    });
    const API_URL = 'http://192.168.0.117:8000/api/user/get-pharmacies';

    final response = await http.get(
      Uri.parse(API_URL),
      headers: {
        'Authorization': 'Bearer $access_Token',
      },
    );
    final data = json.decode(response.body);

    setState(() {
      _pharmaciesList = data;
    });
  }

  @override
  initState() {
    super.initState();
    _fetchPharmaciesList();
  }
}
