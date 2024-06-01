import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_task/core/auth/cubits/CheckEmailPassword/check_email_pass_cubit.dart';
import 'package:host_task/core/auth/cubits/email/email_cubit.dart';
import 'package:host_task/core/auth/cubits/password/login_cubit.dart';
import 'package:host_task/core/auth/presentation/login_screen.dart';
import 'package:host_task/screen/host_screen/cubits/check_status/check_status_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/delivered_Data/fetch_prepared_data_cubit.dart';
import 'package:host_task/screen/host_screen/cubits/ready_data/get_data_cubit.dart';
import 'package:host_task/screen/host_screen/host_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => EmailCubit()),
        BlocProvider(create: (context) => CheckEmailPassCubit()),
        BlocProvider(create: (context) => GetDataCubit()),
        BlocProvider(create: (context) => FetchPreparedDataCubit()),
        BlocProvider(create: (context) => CheckStatusCubit()),



      ],
      child: MaterialApp(
        title: 'Host Screen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
