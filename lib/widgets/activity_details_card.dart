import 'package:finalexam_sensors/light/brightnessManager.dart';
import 'package:finalexam_sensors/model/health_model.dart';
import 'package:finalexam_sensors/stepcounter.dart';
import 'package:flutter/material.dart';
import 'package:finalexam_sensors/gps.dart';
import 'package:finalexam_sensors/light.dart';
import '../accelerometer_dashboard.dart';
import '../data/health_details.dart';
import 'custom_card_widget.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthDetails();
  }
}

class HealthDetails extends StatefulWidget {
  @override
  _HealthDetailsState createState() => _HealthDetailsState();
}

class _HealthDetailsState extends State<HealthDetails> {
  double brightness = BrightnessManager.instance.brightness;

  @override
  void initState() {
    super.initState();
    BrightnessManager.instance.addListener(_updateBrightness);
  }

  @override
  void dispose() {
    super.dispose();
    BrightnessManager.instance.removeListener(_updateBrightness);
  }

  void _updateBrightness(double newBrightness) {
    setState(() {
      brightness = newBrightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    final healthData = [
      HealthModel(
          icon: 'assets/icons/accelero.png',
          value: "44%",
          title: "Accelerometer"),
      HealthModel(
          icon: 'assets/icons/images.png', value: "0", title: "step counts"),
      HealthModel(
          icon: 'assets/icons/gps.png', value: "kk 12 st 93", title: "GPS"),
      HealthModel(
          icon: 'assets/icons/light png.jpeg',
          value: "${(brightness * 100).round()}%",
          title: "Brightness"),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: healthData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Handle card click event
              if (healthData[index].title == 'Accelerometer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccelerometerDashboard(),
                  ),
                );
              } else if (healthData[index].title == 'step counts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepCounterPage(),
                  ),
                );
              } else if (healthData[index].title == 'GPS') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPagez(),
                  ),
                );
              } else if (healthData[index].title == 'Brightness') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LightSensingScreen(),
                  ),
                );
              }
            },
            child: CustomCard(
              child: SizedBox(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      healthData[index].icon,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          healthData[index].value,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          healthData[index].title,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
