import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/core/constants/value.dart';
import 'package:todo_app/app/routes/paths.dart';

class AppRemote {
  AppRemote._();
  static final AppRemote instance = AppRemote._();

  final CollectionReference collection = FirebaseFirestore.instance.collection('remote');

  static Future init() async {
    Map<String, dynamic> config = {
      'app': {
        'lock': false,
      },
      'link': {
        'web': 'https://site.id/',
        'privacy': 'https://site.id/privacy',
      }
    };

    // set up firebase
    AppRemote.instance.collection.doc('config').set(config);
  }

  static Future listen() async {
    AppRemote.instance.collection.doc('config').snapshots().listen((DocumentSnapshot snapshot) {
      print('snapshot: ${snapshot.data()}');
      final data = snapshot.data() as Map<String, dynamic>;

      bool isLocked = data['app']['lock'];

      if (isLocked) {
        globalContext.go(Paths.appLock);
      }
    });
  }
}
