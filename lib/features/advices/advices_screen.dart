import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  String? selectedCategory;
  Map<String, bool> likedAdvice = {};
  Map<String, bool> dislikedAdvice = {};

  @override
  void initState() {
    super.initState();
    context.read<AdviceCubit>().getAdvices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advices')),
      body: BlocBuilder<AdviceCubit, AdviceState>(
        builder: (context, state) {
          if (state is AdviceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdviceLoaded) {
            final categories = state.advices.map((e) => e.diseasesCategoryName).toSet().toList();

            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                ...categories.map(
                  (category) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.blue.shade50,
                        title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Icon(selectedCategory == category ? Icons.expand_less : Icons.expand_more),
                        onTap: () {
                          setState(() => selectedCategory = selectedCategory == category ? null : category);
                        },
                      ),
                      if (selectedCategory == category)
                        ...state.advices
                            .where((e) => e.diseasesCategoryName == category)
                            .map(
                              (advice) => Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(advice.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Text(advice.description),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.thumb_up,
                                              color: likedAdvice[advice.id] == true ? Colors.green : Colors.grey,
                                            ),
                                            onPressed: () async {
                                              await context.read<AdviceCubit>().likeAdvice(advice.id);
                                              setState(() {
                                                likedAdvice[advice.id] = true;
                                                dislikedAdvice[advice.id] = false;
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Liked successfully")),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.thumb_down,
                                              color: dislikedAdvice[advice.id] == true ? Colors.red : Colors.grey,
                                            ),
                                            onPressed: () async {
                                              await context.read<AdviceCubit>().dislikeAdvice(advice.id);
                                              setState(() {
                                                dislikedAdvice[advice.id] = true;
                                                likedAdvice[advice.id] = false;
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Disliked successfully")),
                                              );
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    ],
                  ),
                )
              ],
            );
          } else if (state is AdviceError) {
            return Center(child: Text('Error: ${state.errormessage}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}