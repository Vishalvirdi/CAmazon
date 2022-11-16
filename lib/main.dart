import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submart/providers/user_details_provider.dart';
import 'package:submart/screens/Auth/login_screen.dart';
import 'package:submart/screens/homepage.dart';
import 'package:submart/screens/screen_layout.dart';
import 'package:submart/utils/color_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCybFtIuP4OHG5D8v1TOXjVzwiGrQHg6yw",
      authDomain: "submart-84203.firebaseapp.com",
      projectId: "submart-84203",
      storageBucket: "submart-84203.appspot.com",
      messagingSenderId: "242747927759",
      appId: "1:242747927759:web:f6c5a0b3cb3b23adeadbba",
      measurementId: "G-H8259D2V62",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: 'SubMart',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
                //return const SellScreen();
              } else {
                return const SignInScreen();
              }
            }),
        // SignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
