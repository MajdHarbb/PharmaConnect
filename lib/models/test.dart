import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Copertest extends StatelessWidget {
  const Copertest({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [
    DefaultMaterialLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
    ],
      debugShowCheckedModeBanner: false,
      title: "persistent test",
      home: CupertinoTabScaffold(
        backgroundColor: Colors.amber, tabBuilder: (BuildContext context, int index) { 
              return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Page 1 of tab $index'),
          ),
          child: Center(
            child: CupertinoButton(
              child: const Text('Next page'),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        navigationBar: CupertinoNavigationBar(
                          middle: Text('Page 2 of tab $index'),
                        ),
                        child: Center(
                          child: CupertinoButton(
                            child: const Text('Back'),
                            onPressed: () { Navigator.of(context).pop(); },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
         }, tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Pharmacy',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ]
        ), 
      ),
    );
  }
}