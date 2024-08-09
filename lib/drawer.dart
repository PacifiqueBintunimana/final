import 'package:finalexam_sensors/accelerometer_dashboard.dart';
import 'package:finalexam_sensors/gps.dart';
import 'package:finalexam_sensors/light.dart';
import 'package:finalexam_sensors/stepcounter.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final String currentScreen;

  const DrawerScreen({
    Key? key,
    required this.currentScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Sensors'),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Light'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Light') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LightSensingScreen(),
                  ),
                );
              }
            },
            selected: currentScreen == 'Light Sensor',
          ),
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('Accelerometer Sensor'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Step Counter') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccelerometerDashboard(),
                  ),
                );
              }
            },
            selected: currentScreen == 'Accelerometer Sensor',
          ),
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('steps Sensor'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'Step Counter') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepCounterPage(),
                  ),
                );
              }
            },
            selected: currentScreen == 'step Sensor',
          ),
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('GPS'),
            onTap: () {
              Navigator.pop(context);
              if (currentScreen != 'GPS Tracker') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPagez(),
                  ),
                );
              }
            },
            selected: currentScreen == 'GPS Tracker',
          ),
        ],
      ),
    );
  }
}
