import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/services/locator.dart';
import 'package:vadmin/services/navigationservice.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:vadmin/widgets/customtext.dart';

class AdminDrawer extends StatefulWidget {
  final bool isAdmin;
  const AdminDrawer({this.isAdmin});

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  List<Widget> drawerContainers;
  @override
  void initState() {
    drawerContainers ??= [];
    if (widget.isAdmin) {
      ROUTES.forEach((element) {
        List<String> nameRoute = element.split('.');
        drawerContainers
            .add(DrawerItem(cont: nameRoute[0], route: nameRoute[1]));
        drawerContainers.add(SizedBox(
          height: 5,
        ));
      });
      drawerContainers.add(SignOut());
    } else {
      ROUTES.take(2).forEach((element) {
        List<String> nameRoute = element.split('.');
        drawerContainers
            .add(DrawerItem(cont: nameRoute[0], route: nameRoute[1]));
        drawerContainers.add(SizedBox(
          height: 5,
        ));
      });
      drawerContainers.add(SignOut());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (2 / 3),
      decoration: BoxDecoration(
        color: TRW,
      ),
      child: Container(
        child: Column(
          children: [
            // Header Container
            Container(
              width: double.infinity,
              height: 150,
              color: CN2,
              // child: Column(
              //   children: [
              //     IconButton(
              //       icon: Icon(Icons.search_rounded, color: Colors.white),
              //       onPressed: () {
              //         locator<NavigationService>().navigateTo('/busqueda');
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //     CustomText(
              //       text: 'Buscar ventas o egresos',
              //       color: Colors.white,
              //     )
              //   ],
              // ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: drawerContainers,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String cont;
  final String route;
  const DrawerItem({Key key, @required this.cont, @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(route);
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(color: PR2),
        height: 80,
        child: Center(
          child: Text(
            cont,
            style: GoogleFonts.quicksand(
                color: TX1, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  const SignOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.cubit<FirebaseCubit>().state.signOut();
      },
      child: Container(
        decoration: BoxDecoration(color: CN1),
        height: 80,
        child: Center(
          child: Text(
            'Cerrar sesión',
            style: GoogleFonts.quicksand(
                color: TX2, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
