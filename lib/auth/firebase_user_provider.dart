import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RideDriverFirebaseUser {
  RideDriverFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

RideDriverFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RideDriverFirebaseUser> rideDriverFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<RideDriverFirebaseUser>(
      (user) {
        currentUser = RideDriverFirebaseUser(user);
        return currentUser!;
      },
    );
