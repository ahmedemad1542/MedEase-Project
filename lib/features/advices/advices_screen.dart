import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

class AdviceScreen extends StatelessWidget {
  
  const AdviceScreen({super.key });

  void _showAddDialog(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Advice'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Advice Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<AdviceCubit>().createAdvice(
                    diseasesCategoryId: '1',
                    title: controller.text,
                  );
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, AdviceModel advice) {
    final controller = TextEditingController(text: advice.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Advice'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Edit Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<AdviceCubit>().updateAdvice(
                    adviceId: advice.id,
                    diseasesCategoryId: '1',
                    title: controller.text,
                    description: advice.description,
                  );
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();

    context.read<AdviceCubit>().fetchAdvices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context, _titleController),
          ),
        ],
      ),
      body: BlocBuilder<AdviceCubit, AdviceState>(
        builder: (context, state) {
          if (state is AdviceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdviceLoaded) {
            return ListView.builder(
              itemCount: state.advices.length,
              itemBuilder: (context, index) {
                final advice = state.advices[index];
                return GestureDetector(
                  onLongPress: () => _showUpdateDialog(context, advice),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(advice.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up),
                              onPressed: () {
                                // TODO: like API
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.thumb_down),
                              onPressed: () async {
                                await context.read<AdviceCubit>().createDislike(
                                      diseasesCategoryId: '1',
                                      title: advice.title,
                                      description: advice.description,
                                      doctorId: advice.doctorId,
                                    );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
