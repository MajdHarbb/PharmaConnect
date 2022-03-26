import 'package:flutter/material.dart';
import 'package:pharmaconnectflutter/welcome/patient_or_pharmacy.dart';
import 'package:pharmaconnectflutter/welcome/welcome_signin.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only( left: 15.0, top: 50, right: 15.0, bottom: 80),
          child: Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PatientOrPharmacy()),
                          );
                          
                        },
                        child: const Text("Skip")),
                        const Icon(Icons.skip_next_sharp, color: Colors.blue),
                  ],
                ),
                Image.asset('assets/images/pharmacy.png'),

                const Text(
                  'Find your medicine fast and easy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),

                const Text(
                  'Now you can find your medicine with few clicks, no need for driving across the country anymore!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, letterSpacing: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomePagetwo()),
                          );
                          
                        },
                        child: const Text("Next")),
                        const Icon(Icons.skip_next_sharp, color: Colors.blue),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePagetwo extends StatelessWidget {
  const WelcomePagetwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route wl'),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           
            Image.asset('assets/images/logo.png'),

            const Text(
              'Post about any medicine and know it’s location',
            ),
            const Text(
              'Now you can find your medicine with few clicks, no need for driving across the country anymore!',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeSignIn()),
                );
              },
              child: const Text('Next    >'),
            ),
          ],
        ),
      ),
    );
  }
}
