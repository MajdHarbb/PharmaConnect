import 'package:flutter/material.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({Key? key}) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _PatientSearchState extends State<PatientSearch> {
  final List<Item> _data = generateItems(3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _buildPanel(),
          ),
        ));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Column(
              
              children: [
              Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
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
              ],
            );
          },
          body: ListTile(
              title: Text("testttt"),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.save),
              
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
