import 'package:flutter/material.dart';

import '../util/responsive.dart';
import 'activity_details_card.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ColoredBox(
              color: Colors.orange,
              child: Image(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.width *
                    0.6, // Adjust the height as needed
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/smart.jpeg'),
              ),
            ),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
