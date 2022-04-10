import 'package:flutter/material.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            
            Text("PharmaConnect is an app to combat medicine shortages in Lebanon. PharmaConnect is more than an app or a practice of code; this app serves a good cause, reduces the impact of the disastrous medicine shortages, and maybe even, saves a soul.",
            style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify),
            SizedBox(height: 20.0,),
            Text("PharmaConnect connects medicine seekers with pharmacy owners. For example, instead of driving across the entire country to find your medicine, you can simply register, create a post detailing the medicine that you're looking for ie. with a caption and a picture and you'll get a reply from all the pharmacies that have your requested medicine.",
            style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify),

          ],
        ),
      )
    );
  }
}
