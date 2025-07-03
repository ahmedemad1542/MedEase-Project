import 'package:flutter/material.dart';
import 'package:medease1/generated/l10n.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  BmiPageState createState() => BmiPageState();
}

class BmiPageState extends State<BmiPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmi = 0;
  String bmiMessage = "";

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      setState(() {
        bmi = weight / (heightInMeters * heightInMeters);

        // تحديد الرسالة بناءً على قيمة BMI
        if (bmi < 18.5) {
          bmiMessage = S.of(context).bmiresult1;
        } else if (bmi >= 18.5 && bmi < 25.0) {
          bmiMessage = S.of(context).bmiresult2;
        } else {
          bmiMessage = S.of(context).bmiresult3;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).bmicalculator)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: S.of(context).hieght),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: S.of(context).weight),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text(S.of(context).bmiResult),
            ),
            SizedBox(height: 20),
            Text(
              "${S.of(context).bmi} : ${bmi.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              bmiMessage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
