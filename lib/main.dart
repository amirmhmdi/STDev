import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/screens/add_contact.dart';
import 'package:stdev_task/screens/detail_contact.dart';
import 'package:stdev_task/screens/edit_contact.dart';
import 'package:stdev_task/screens/list_contact.dart';

void main() async {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = false;
final ThemeData lighttheme = ThemeData(
  primaryColor: Colors.green,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
final ThemeData darktheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CantactBlocCubit(),
      child: OKToast(
        textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
        backgroundColor: Colors.grey,
        animationCurve: Curves.easeIn,
        animationDuration: const Duration(milliseconds: 200),
        duration: const Duration(seconds: 3),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode: (isDark == true) ? ThemeMode.dark : ThemeMode.light,
          routes: {
            "/": (context) => const ListContact(),
            "addcontactpage": (context) => const AddContactPage(),
            "detailpage": (context) => const DetailPage(),
            "editpage": (context) => const EditPage(),
          },
        ),
      ),
    );
  }
}
