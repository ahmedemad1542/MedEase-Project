import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AdvicesPage extends StatefulWidget {
  const AdvicesPage({super.key});

  @override
  AdvicesPageState createState() => AdvicesPageState();
}

class AdvicesPageState extends State<AdvicesPage> {
  List<Map<String, dynamic>> advices = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    loadAdvices();
  }

  Future<void> loadAdvices() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/advices.json',
      );
      final List<dynamic> data = json.decode(response);

      setState(() {
        advices = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "حدث خطأ أثناء تحميل النصائح - حاول مرة أخرى";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("نصائح طبية")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
                itemCount: advices.length,
                itemBuilder: (context, index) {
                  final advice = advices[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        advice['title'] ?? "عنوان غير متوفر",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        advice['description'] ?? "تفاصيل غير متوفرة",
                      ),
                      leading: Icon(
                        Icons.health_and_safety,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
