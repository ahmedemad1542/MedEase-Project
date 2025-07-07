import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';

class MedEaseHomeScreen extends StatelessWidget {
  const MedEaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(' MedEase', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'MedEase! مرحبًا بك',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'إنشاء تجربة طبية أفضل من خلال الخدمات التي نقدمها',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                FeatureCard(
                  icon: Icons.local_hospital,
                  label: 'الأطباء',
                  onTap: () {
                    context.pushNamed(AppRoutes.doctorsScreen);
                  },
                ),
                FeatureCard(
                  icon: Icons.shield,
                  label: 'المرضي',
                  onTap: () {
                    context.pushNamed(AppRoutes.patientScreen);
                  },
                ),
                FeatureCard(
                  icon: Icons.calculate,
                  label: 'حاسبة',
                  onTap: () {
                    context.pushNamed(AppRoutes.bmiCalculatorScreen);
                  },
                ), //TODO
                FeatureCard(
                  icon: Icons.chat,
                  label: 'Chatbot',
                  onTap: () {
                    context.pushNamed(AppRoutes.chatBotScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
