// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class DiseasesPage extends StatefulWidget {
//   const DiseasesPage({super.key});

//   @override
//   DiseasesPageState createState() => DiseasesPageState();
// }

// class DiseasesPageState extends State<DiseasesPage> {
//   List<dynamic> _diseases = [];

//   @override
//   void initState() {
//     super.initState();
//     loadDiseases();
//   }

//   Future<void> loadDiseases() async {
//     String data = await rootBundle.loadString(
//       'assets/diseases.json',
//     ); // ✅ تحميل ملف JSON
//     Map<String, dynamic> jsonData = json.decode(data);
//     setState(() {
//       _diseases =
//           jsonData['diseases'].values
//               .expand((category) => category as List)
//               .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Diseases List")),
//       body:
//           _diseases.isEmpty
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 itemCount: _diseases.length,
//                 itemBuilder: (context, index) {
//                   var disease = _diseases[index];
//                   return ListTile(
//                     title: Text(
//                       disease['name'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       disease['symptoms'].join(", "),
//                     ), // ✅ عرض بعض الأعراض
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text(disease['name']),
//                             content: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "🔹 **الأسباب:**\n${disease['causes'].join("\n")}",
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     "⚠️ **الأعراض:**\n${disease['symptoms'].join("\n")}",
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     "💊 **الأدوية:**\n${disease['medications'].join("\n")}",
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     "✅ **الوقاية:**\n${disease['prevention'].join("\n")}",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text("إغلاق"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//     );
//   }
// }
