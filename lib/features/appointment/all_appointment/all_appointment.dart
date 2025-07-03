// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medease1/core/utils/service_locator.dart';
// import 'package:medease1/features/profile/cubit/profile_cubit.dart';
// import 'package:medease1/features/profile/cubit/profile_state.dart';
// import 'package:medease1/features/profile/repo/profile_repo.dart';

// class MyAppointment extends StatelessWidget {
//   const MyAppointment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileCubit(sl<ProfileRepo>())..fetchProfile(),
//       child: Scaffold(
//         body: BlocConsumer<ProfileCubit, ProfileState>(
//           listener: (context, state) {
//             if (state is ProfileError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Error: ${state.message}')),
//               );
//             }
//             if (state is ProfileLoaded) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Profile loaded successfully')),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileLoaded) {
//               final user = state.user;
//               return ListView.builder(
//                 itemCount: user.appointments.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(user.appointments[index]['doctorName']),
//                     subtitle: Text(user.appointments[index]['appointmentDate']),
//                   );
//                 },
//               );
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_cubit.dart';
import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_state.dart';

// class MyAppointment extends StatelessWidget {
//   const MyAppointment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileCubit(sl<ProfileRepo>())..fetchProfile(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('مواعيدي')),
//         body: BlocConsumer<ProfileCubit, ProfileState>(
//           listener: (context, state) {
//             if (state is ProfileError) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text('خطأ: ${state.message}')));
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileLoaded) {
//               final user = state.user;
//               if (user.appointments.isEmpty) {
//                 return const Center(child: Text('لا توجد مواعيد متاحة'));
//               }

//               return ListView.builder(
//                 itemCount: user.appointments.length,
//                 itemBuilder: (context, index) {
//                   final appointment = user.appointments[index];
//                   return Card(
//                     margin: const EdgeInsets.all(8),
//                     child: ListTile(
//                       title: Text(
//                         appointment.doctorName,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'التاريخ: ${_formatDate(appointment.appointmentDate)}',
//                           ),
//                           Text('الأولوية: ${appointment.priority}'),
//                         ],
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: BlocConsumer<GetAppointmentCubit, GetAppointmentState>(
        listener: (BuildContext context, state) {
          if (state is GetAppointmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
          if (state is GetAppointmentLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('My appointments loaded successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is GetAppointmentLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading appointments..."),
                ],
              ),
            );
          } else if (state is GetAppointmentLoaded) {
            final appointments = state.appointment;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final priorityColor = _getPriorityColor(appointment.priority);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today, color: priorityColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. ${appointment.doctorName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Date: ${DateFormat('dd-MM-yyyy').format(appointment.appointmentDate)}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Text(
                                    'Priority: ',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    appointment.priority,
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetAppointmentError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('No profile data available'));
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'important':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
