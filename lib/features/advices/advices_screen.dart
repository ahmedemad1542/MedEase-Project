import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';

class AdvicesScreen extends StatelessWidget {
  const AdvicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advices")),
      body: BlocConsumer<AdvicesCubit, AdvicesState>(
        listener: (context, state) {
          if (state is AdvicesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is AdvicesLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Advices loaded successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is AdvicesLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading advices..."),
                ],
              ),
            );
          }
          if (state is AdvicesLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.advicesmodel.length,
              itemBuilder: (context, index) {
                final advice = state.advicesmodel[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: const Icon(
                      Icons.lightbulb_outline,
                      color: Colors.teal,
                    ),
                    title: Text(
                      advice.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        advice.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    onTap: () {
                      // Add navigation or detail view if needed
                    },
                  ),
                );
              },
            );
            // return ListView.builder(
            //   itemCount: state.advicesmodel.length,
            //   itemBuilder: (context, index) {
            //     final advice = state.advicesmodel[index];
            //     return ListTile(
            //       title: Text(advice.title),
            //       subtitle: Text(advice.description),
            //     );
            //   },
            // );
          }
          return Center();
        },
      ),
    );
  }
}
