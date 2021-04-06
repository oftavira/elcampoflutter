import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit/cubit.dart';
import 'package:vadmin/firebase_tools/firebase_service.dart';
import 'package:vadmin/models/date_model.dart';

class FirebaseCubit extends Cubit<FirebaseService> {
  FirebaseService fService;
  FirebaseCubit(FirebaseService fService) : super(fService);

  Future<String> csignIn(String email, String pass) {
    return state.signIn(email, pass);
  }

  Future<String> signOut() {
    return state.signOut();
  }

  //Reads the info within a profile
  Future<bool> isAdmin() async {
    DocumentSnapshot _bool =
        await state.db.collection('administracion').doc('usuarios').get();
    // debugP("_bool in isAdmin", _bool);
    Map<String, dynamic> _m = _bool.data();
    // debugP("_m in isAdmin", _m);
    state.adminVal(_m[state.email]['admin']);
    return _m[state.email]['admin'];
  }

  Stream<DocumentSnapshot> userStreamSnapshot() {
    return state.db.collection('administracion').doc('usuarios').snapshots();
  }

  // Checks if the month exists in the db, and manages the global info
  // contained by the document itself, the document contains a collection
  // of the days and outcomes TODO: Change this pattern to a more convenient (days to sales)

  Stream<QuerySnapshot> checkMonth(Date d) {
    // Checking if the current month exists as a document with info
    DocumentReference ref = state.db.collection('ventas').doc(d.ym);
    ref.get().then(
      (doc) {
        if (doc.exists) {
          print('\n The month info exists in the DB');
          print(doc.data().toString());
        } else {
          print('\n Creating month document information');
          ref.set({'id': d.ym, 'outcome': 0, 'total': 0});
        }
      },
    );
    // Returning the snapshots in 'ventas'
    return state.db.collection('ventas').snapshots();
  }

  Stream<QuerySnapshot> monthSales(Date d) {
    return state.db.collection('ventas/${d.ym}/days').snapshots();
  }

  Stream<QuerySnapshot> monthOutcomes(Date d) {
    return state.db.collection('ventas/${d.ym}/outcomes').snapshots();
  }

  // Generates a streamDocument information given the date month-year
  // ventas/${month}/days/${yyyy-mm-dd}

  Stream<DocumentSnapshot> daySales(String m, String d) {
    return state.db.collection('ventas/$m/days/').doc('$d').snapshots();
  }

  Stream<DocumentSnapshot> dayOutcomes(String m, String d) {
    return state.db.collection('ventas/$m/outcomes/').doc('$d').snapshots();
  }
}
