import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color.fromRGBO(179, 111, 212, 1),
              Color.fromRGBO(103, 87, 186, 1),
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 1.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash-bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Language'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Album'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Moving around in TIME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/user-avatar.png'),
                        radius: 120.0,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    height: 100.0,
                    constraints: const BoxConstraints(maxWidth: 200.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/import');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
