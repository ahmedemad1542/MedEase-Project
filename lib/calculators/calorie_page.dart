import 'package:flutter/material.dart';

class CaloriePage extends StatefulWidget {
  const CaloriePage({super.key});

  @override
  CaloriePageState createState() => CaloriePageState();
}

class CaloriePageState extends State<CaloriePage> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double calories = 0;

  void calculateCalories() {
    double age = double.tryParse(ageController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (age > 0 && weight > 0 && height > 0) {
      setState(() {
        calories = 10 * weight + 6.25 * height - 5 * age + 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("حاسبة السعرات الحرارية")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "العمر"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: "الوزن (كجم)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: "الطول (سم)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCalories,
              child: Text("احسب السعرات"),
            ),
            SizedBox(height: 20),
            Text(
              "السعرات المطلوبة: ${calories.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
