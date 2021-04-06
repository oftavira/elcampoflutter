import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadmin/constants.dart';
import 'package:vadmin/firebase_tools/firebase_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

// TODO: Implement accounts managing inside the App
//
class AccountsView extends StatelessWidget {
  const AccountsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.cubit<FirebaseCubit>().state.email);
    void ts(String user, String pass) {
      context.cubit<FirebaseCubit>().state
        ..testing(user, pass)
        ..db.collection('administracion').doc('usuarios').set({
          user: {'admin': true}
        }, SetOptions(merge: true));
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [CN2, CN1]),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text('Añadir usuario',
                        style: TextStyle(
                            color: TX1, fontWeight: FontWeight.w700))),
                RaisedButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddUser(f: ts);
                        });
                  },
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Streaming(),
          )
        ],
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  final cont1 = TextEditingController();
  final cont2 = TextEditingController();
  final void Function(String, String) f;
  AddUser({this.f});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CN2,
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(10),
      title: Container(
        height: 40,
        color: CN1,
        child: Text('Añadir usuario'),
      ),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, color: TX1),
                controller: cont1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, color: TX1),
                controller: cont2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  this.f(cont1.text, cont2.text);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Streaming extends StatelessWidget {
  const Streaming({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: context.cubit<FirebaseCubit>().userStreamSnapshot(),
      builder: (context, usersDocSnapshot) {
        if (usersDocSnapshot.hasData) {
          List<List> _ls = [];
          usersDocSnapshot.data.data().forEach((key, value) {
            _ls.add([key.toString(), value.toString()]);
          });
          return Container(
            padding: EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (c, i) =>
                  UserWidget(email: _ls[i][0], status: _ls[i][1]),
              shrinkWrap: true,
              separatorBuilder: (c, i) => Divider(height: 10),
              itemCount: _ls.length,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class UserWidget extends StatelessWidget {
  final String email;
  final String status;
  const UserWidget({Key key, @required this.email, @required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: PR1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(email + status), Icon(Icons.account_circle)],
      ),
    );
  }
}
