import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final userC = TextEditingController();
  final passC = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  void dispose() {
    userC.dispose();
    passC.dispose();
    super.dispose();
  }
  // Clean up the controller when the widget is disposed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Whole screeen container
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('assets/laundry.jpg'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: CN2,
                  ),
                )
              ],
            ),
            Center(
              // Avoid keyboard overlaping
              child: SingleChildScrollView(
                controller: _controller,
                // Login container
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), color: TRPR2),
                  // Login form column
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // User textfield
                      Container(
                        child: Center(
                          child: TextField(
                            style: GoogleFonts.quicksand(
                                color: TX1, fontWeight: FontWeight.w700),
                            cursorColor: TX1,
                            controller: userC,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.quicksand(
                                    color: TX3, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: TX1, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: CN1, width: 2),
                                ),
                                hintText: 'Usuario'),
                          ),
                        ),
                      ),
                      // Password textfield
                      Container(
                        child: Center(
                          child: TextField(
                            style: GoogleFonts.quicksand(
                                color: TX1, fontWeight: FontWeight.w700),
                            cursorColor: TX1,
                            controller: passC,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.quicksand(
                                    color: TX3, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: TX1, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: CN1, width: 2),
                                ),
                                hintText: 'Clave'),
                          ),
                        ),
                      ),
                      // Login button
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          context
                              .cubit<FirebaseCubit>()
                              .state
                              .signIn(userC.text, passC.text);
                          setState(() {});
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: CN1,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Ingresar',
                                style: GoogleFonts.quicksand(
                                    color: TX1, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.account_circle, color: TX1)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
