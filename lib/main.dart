import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/firebase_tools/firebase_service.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/router.dart';
import 'package:vadmin/services/locator.dart';
import 'package:vadmin/services/navigationservice.dart';
import 'package:vadmin/signin/signin_view.dart';
import 'package:vadmin/widgets/drawer.dart';

void main() async {
  // GetIt instances SetUp
  setupLocator();
  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavanderia El Campo',
      theme: ThemeData(
        primaryColor: CN2,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: Root()),
    );
  }
}

// The Root widget provides acces to the app if the user has credentials
// and displays the proper options in the side bar, according to the
// privileges admin or regular.

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This Firebase cubit is to provide DB info
    return CubitProvider(
      create: (_) => FirebaseCubit(FirebaseService()),
      child: CubitBuilder<FirebaseCubit, FirebaseService>(
        builder: (context, fbService) {
          return StreamBuilder(
            // Checks for the current status in the firebase login API
            stream: fbService.auStChanges,
            builder: (context, authSnapshot) {
              if (authSnapshot.connectionState == ConnectionState.active) {
                // Check if there is data available
                if (authSnapshot.hasData) {
                  return FutureBuilder(
                      future: context.cubit<FirebaseCubit>().isAdmin(),
                      builder: (context, privilegeSnapshot) {
                        if (privilegeSnapshot.hasData) {
                          return AuthenticatedView();
                        } else {
                          // TODO: display a message for invalid credentials
                          return SignIn();
                        }
                      });
                } else {
                  return SignIn();
                }
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          );
        },
      ),
    );
  }
}

class AuthenticatedView extends StatelessWidget {
  AuthenticatedView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TX2,
      child: WillPopScope(
        // This is added to avoid app closing when pressing the back button
        // in that case this button leads to the main financial view
        onWillPop: () async {
          locator<NavigationService>().navigateTo('/finanzas');
          return false;
        },
        child: Scaffold(
          drawer: AdminDrawer(
              isAdmin: context.cubit<FirebaseCubit>().state.adminView),
          appBar: AppBar(
            title: Text(
              "El Campo",
              style: GoogleFonts.quicksand(
                  color: TX1, fontWeight: FontWeight.w800, fontSize: 22),
            ),
          ),
          body: Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              color: TX2,
            ),
            Navigator(
              key: locator<NavigationService>().navigatorKey,
              onGenerateRoute: generateRoute,
              initialRoute: '/nota',
            )
          ]),
        ),
      ),
    );
  }
}
