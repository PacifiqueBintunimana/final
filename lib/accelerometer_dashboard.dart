/*import 'dart:async';

import 'package:finalexam_sensors/drawer.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AccelerometerDashboard extends StatefulWidget {
  const AccelerometerDashboard({Key? key}) : super(key: key);

  @override
  _AccelerometerDashboardState createState() => _AccelerometerDashboardState();
}

class _AccelerometerDashboardState extends State<AccelerometerDashboard> {
  late List<double> _accelerometerValues;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  Timer? _motionTimer;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _accelerometerValues = [0.0, 0.0, 0.0];

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _handleMovementDetection();
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _motionTimer?.cancel();
    super.dispose();
  }

  void _handleMovementDetection() {
    final isMoving = _isDeviceMoving();
    if (isMoving != _isMoving) {
      // if (isMoving ) {
      _isMoving = isMoving;
      if (_isMoving) {
        _startMotionTimer();
      } else {
        _stopMotionTimer();
      }
    }
  }

  bool _isDeviceMoving() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return magnitude > 0.1; // Adjust this threshold based on sensitivity
  }

  void _startMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(Duration(seconds: 2), () {
      // Trigger notification for stationary state
      _showNotification('Device is in motion');
    });
  }

  void _stopMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(Duration(seconds: 10), () {
      // Trigger notification for stationary state
      _showNotification('Device is not in motion');
    });
  }

  void _showNotification(String message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Motion Alert',
        body: message,
        // customSound: 'raw/notification.mp3',
        customSound: 'resource://raw/notification.mp3',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Dashboard'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerScreen(
        currentScreen: 'Accelerometer Sensor',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 20.0,
              percent: _calculateMovementPercent(),
              center: Text(
                '${(_calculateMovementPercent() * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.teal,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSensorCard('X', _accelerometerValues[0]),
                _buildSensorCard('Y', _accelerometerValues[1]),
                _buildSensorCard('Z', _accelerometerValues[2]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMovementPercent() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return (magnitude / 10.0).clamp(0.0, 1.0);
  }

  Widget _buildSensorCard(String title, double value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccelerometerDashboard(),
  ));
}

import 'dart:async';

import 'package:finalexam_sensors/drawer.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AccelerometerDashboard extends StatefulWidget {
  const AccelerometerDashboard({Key? key}) : super(key: key);

  @override
  _AccelerometerDashboardState createState() => _AccelerometerDashboardState();
}

class _AccelerometerDashboardState extends State<AccelerometerDashboard> {
  late List<double> _accelerometerValues;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  Timer? _motionTimer;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _accelerometerValues = [0.0, 0.0, 0.0];

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _handleMovementDetection();
      });
    });

    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_stat_acme_logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _motionTimer?.cancel();
    super.dispose();
  }

  void _handleMovementDetection() {
    final isMoving = _isDeviceMoving();
    if (isMoving != _isMoving) {
      _isMoving = isMoving;
      if (_isMoving) {
        _startMotionTimer();
      } else {
        _stopMotionTimer();
      }
    }
  }

  bool _isDeviceMoving() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return magnitude > 0.1; // Adjust this threshold based on sensitivity
  }

  void _startMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 2), () {
      // Trigger notification for motion state
      _showNotification('Device is in motion');
    });
  }

  void _stopMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 10), () {
      // Trigger notification for stationary state
      _showNotification('Device is not in motion');
    });
  }

  void _showNotification(String message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Motion Alert',
        body: message,
        // customSound: 'raw/notification.mp3',
        customSound: 'resource://raw/notification.mp3',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Dashboard'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerScreen(
        currentScreen: 'Accelerometer Sensor',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 20.0,
              percent: _calculateMovementPercent(),
              center: Text(
                '${(_calculateMovementPercent() * 100).toStringAsFixed(1)}%',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.teal,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSensorCard('X', _accelerometerValues[0]),
                _buildSensorCard('Y', _accelerometerValues[1]),
                _buildSensorCard('Z', _accelerometerValues[2]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMovementPercent() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return (magnitude / 10.0).clamp(0.0, 1.0);
  }

  Widget _buildSensorCard(String title, double value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AccelerometerDashboard(),
  ));
}
import 'dart:async';

import 'package:finalexam_sensors/drawer.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AccelerometerDashboard extends StatefulWidget {
  const AccelerometerDashboard({Key? key}) : super(key: key);

  @override
  _AccelerometerDashboardState createState() => _AccelerometerDashboardState();
}

class _AccelerometerDashboardState extends State<AccelerometerDashboard> {
  late List<double> _accelerometerValues;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  Timer? _motionTimer;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _accelerometerValues = [0.0, 0.0, 0.0];

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _handleMovementDetection();
      });
    });

    _initNotifications();
  }

  void _initNotifications() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_stat_acme_logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _motionTimer?.cancel();
    super.dispose();
  }

  void _handleMovementDetection() {
    final isMoving = _isDeviceMoving();
    if (isMoving && !_isMoving) {
      _isMoving = true;
      _startMotionTimer();
    } else if (!isMoving && _isMoving) {
      _isMoving = false;
      _stopMotionTimer();
    }
  }

  bool _isDeviceMoving() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return magnitude > 0.1; // Adjust this threshold based on sensitivity
  }

  void _startMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 2), () {
      // Trigger notification for motion state
      _showNotification('Device is in motion');
    });
  }

  void _stopMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 10), () {
      // Trigger notification for stationary state
      _showNotification('Device is not in motion');
    });
  }

  void _showNotification(String message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Motion Alert',
        body: message,
        // customSound: 'raw/notification.mp3',
        customSound: 'resource://raw/notification.mp3',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Dashboard'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerScreen(
        currentScreen: 'Accelerometer Sensor',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 20.0,
              percent: _calculateMovementPercent(),
              center: Text(
                '${(_calculateMovementPercent() * 100).toStringAsFixed(1)}%',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.teal,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSensorCard('X', _accelerometerValues[0]),
                _buildSensorCard('Y', _accelerometerValues[1]),
                _buildSensorCard('Z', _accelerometerValues[2]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMovementPercent() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return (magnitude / 10.0).clamp(0.0, 1.0);
  }

  Widget _buildSensorCard(String title, double value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AccelerometerDashboard(),
  ));
}
*/
import 'dart:async';

import 'package:finalexam_sensors/drawer.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:finalexam_sensors/notification_service.dart';

class AccelerometerDashboard extends StatefulWidget {
  const AccelerometerDashboard({Key? key}) : super(key: key);

  @override
  _AccelerometerDashboardState createState() => _AccelerometerDashboardState();
}

class _AccelerometerDashboardState extends State<AccelerometerDashboard> {
  late List<double> _accelerometerValues;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  Timer? _motionTimer;
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _accelerometerValues = [0.0, 0.0, 0.0];

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _handleMovementDetection();
      });
    });

    NotificationService.initializeNotifications();
    NotificationService.requestNotificationPermission();
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _motionTimer?.cancel();
    super.dispose();
  }

  void _handleMovementDetection() {
    final isMoving = _isDeviceMoving();
    if (isMoving && !_isMoving) {
      _isMoving = true;
      _startMotionTimer();
    } else if (!isMoving && _isMoving) {
      _isMoving = false;
      _stopMotionTimer();
    }
  }

  bool _isDeviceMoving() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return magnitude > 0.1; // Adjust this threshold based on sensitivity
  }

  void _startMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 2), () {
      // Trigger notification for motion state
      NotificationService.showBasicNotification(
        title: 'Motion Detected',
        body: 'The device is in motion',
      );
    });
  }

  void _stopMotionTimer() {
    _motionTimer?.cancel(); // Cancel any existing timer
    _motionTimer = Timer(const Duration(seconds: 10), () {
      // Trigger notification for stationary state
      NotificationService.showBasicNotification(
        title: 'Motion Stopped',
        body: 'The device is not in motion',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Dashboard'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerScreen(
        currentScreen: 'Accelerometer Sensor',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 20.0,
              percent: _calculateMovementPercent(),
              center: Text(
                '${(_calculateMovementPercent() * 100).toStringAsFixed(1)}%',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.teal,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSensorCard('X', _accelerometerValues[0]),
                _buildSensorCard('Y', _accelerometerValues[1]),
                _buildSensorCard('Z', _accelerometerValues[2]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateMovementPercent() {
    final magnitude = (_accelerometerValues[0].abs() +
            _accelerometerValues[1].abs() +
            _accelerometerValues[2].abs()) /
        3.0;
    return (magnitude / 10.0).clamp(0.0, 1.0);
  }

  Widget _buildSensorCard(String title, double value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
