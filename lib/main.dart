import 'package:finalexam_sensors/drawer.dart';
import 'package:finalexam_sensors/widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   NotificationService.initializeNotifications();
//   NotificationService.requestNotificationPermission();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);vs

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xFF15131C),
//         brightness: Brightness.dark,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       // home: const MainScreen(),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('sensors'),
//       ),

//       body: SafeArea(
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: DashboardWidget(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   NotificationService.initializeNotifications();
//   NotificationService.requestNotificationPermission();
//   runApp(MyApp());
// }

void main() async {
  runApp(MyApp());
  await initNotifications();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor App'),
      ),
      drawer: DrawerScreen(currentScreen: 'Home'),
      body: Center(
        child: DashboardWidget(),
      ),
    );
  }
}
