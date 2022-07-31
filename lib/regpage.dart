import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegPage extends StatefulWidget {
  @override
  RegState createState() => RegState();
}

class RegState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          debugPrint('yeah now you have done it');
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
        child: Center(
          child: Text('Googe Sign in'),
        ),
      ),
    );
  }
}

class FindPlace extends StatefulWidget {
  const FindPlace({Key? key}) : super(key: key);

  @override
  FindPlaceState createState() => FindPlaceState();
}

class FindPlaceState extends State<FindPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
            title: const Text('Trasporto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontFamily: 'RubikMoonrocks')),
            centerTitle: true,
            foregroundColor: Colors.cyan[300],
            surfaceTintColor: Colors.green[100],
            shadowColor: Colors.cyan[900],
            backgroundColor: Colors.cyan[600]),*/
        body: Container(
      color: const Color.fromARGB(255, 0, 225, 255),
      child: Title(
          title: 'Trasporto',
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Align(
                    child: Image(
                        image: AssetImage('assets/logo_transport.png'),
                        height: 350.0,
                        width: 350.0)),
                const SizedBox(
                  height: 150.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Color.fromARGB(255, 0, 225, 255)),
                      label: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Sign In with Google',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 225, 255),
                            fontFamily: 'JosefinSans',
                            fontSize: 30.0,
                          ),
                        ),
                      )),
                ),
              ])),
    ));
  }
}
