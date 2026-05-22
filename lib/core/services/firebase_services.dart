import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/features/add_event/data/models/event_model.dart';
import 'package:evently/features/login/data/models/sign_in_model.dart';
import 'package:evently/features/sign_up/data/models/sign_up_model.dart';
import 'package:evently/features/sign_up/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> login(SignInModel signInModel) async {
    UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
      email: signInModel.email,
      password: signInModel.password,
    );
    return user;
  }

  static Future<UserCredential> signUp(SignUpModel signUpModel) async {
    UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
      email: signUpModel.email,
      password: signUpModel.password,
    );

    return user;
  }

  static CollectionReference<Map<String, dynamic>> usersCollection = firestore
      .collection('users');

  static Future<void> saveUser(UserModel userModel) async {
    DocumentReference<Map<String, dynamic>> userDoc = usersCollection.doc(
      userModel.userId,
    );
    await userDoc.set(userModel.toJson());
  }

  static Future<UserModel> getUser(String userId) async {
    DocumentReference<Map<String, dynamic>> userDoc = usersCollection.doc(
      userId,
    );
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await userDoc
        .get();
    return UserModel.fromJson(documentSnapshot.data()!);
  }

  static Future<UserModel?> getCurrentUser() async {
    if (firebaseAuth.currentUser == null) return null;
    return await getUser(firebaseAuth.currentUser!.uid);
  }

  static CollectionReference<EventModel> eventsCollection = firestore
      .collection('events')
      .withConverter<EventModel>(
        fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
        toFirestore: (event, _) => event.toJson(),
      );

  static Future<List<EventModel>> getEvents(String categoryId) async {
    QuerySnapshot<EventModel> snapShot = await eventsCollection
        .where("categoryId", isEqualTo: categoryId == "0" ? null : categoryId)
        .orderBy("date")
        .get();
    List<EventModel> events = snapShot.docs.map((doc) => doc.data()).toList();
    return events;
  }

  static Future<void> addEvent(EventModel eventModel) async {
    DocumentReference<EventModel> doc = eventsCollection.doc();
    EventModel modelWithId = EventModel(
      eventId: doc.id,
      userId: eventModel.userId,
      title: eventModel.title,
      description: eventModel.description,
      date: eventModel.date,
      categoryId: eventModel.categoryId,
      imagePath: eventModel.imagePath,
    );
    return doc.set(modelWithId);
  }

  static Future<void> updateEvent(EventModel eventModel) async {
    return eventsCollection.doc(eventModel.eventId).update(eventModel.toJson());
  }

  static Future<void> deleteEvent(String eventId) async {
    return eventsCollection.doc(eventId).delete();
  }

  static Future<UserCredential> signInWithGoogle() async {
    await GoogleSignIn.instance.initialize();
    final googleUser = await GoogleSignIn.instance.authenticate();
    GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> updateFavorites(String eventId) async {
    UserModel? currentUser = await getCurrentUser();
    if (currentUser!.favorites.contains(eventId)) {
      currentUser.favorites.remove(eventId);
      log('removing from favourites eventId: $eventId');
    } else {
      currentUser.favorites.add(eventId);
      log('adding to favourites eventId: $eventId');
    }
    await usersCollection.doc(currentUser.userId).update({
      'favorites': currentUser.favorites,
    });
  }

  static Future<List<EventModel>> getFavouriteEvents() async {
    UserModel? currentUser = await getCurrentUser();
    List<EventModel> allEvents = await getEvents('0');
    return allEvents.where((event) {
      return currentUser!.favorites.contains(event.eventId);
    }).toList();
  }

  static Future<void> logout() async {
    await firebaseAuth.signOut();
    await GoogleSignIn.instance.signOut();
  }
}
