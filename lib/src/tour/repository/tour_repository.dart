import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_tips_admin/src/tour/models/tour.dart';

class TourRepository {
  final _db = FirebaseFirestore.instance;
  Future<void> addData(Tour tour) async {
    try {
      await _db.collection('tours').doc(tour.id).set(tour.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tour>> getTours() async {
    try {
      final snapshot = await _db.collection('tours').get();
      final data = snapshot.docs;
      final tours = data.map((e) => Tour.fromJson(e.data())).toList();
      return tours;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTour(String id) async {
    try {
      await _db.collection('tours').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage(File file, String tourId) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('tourImages/$tourId.jpg');
      await imagesRef.putFile(file);
      final url = await imagesRef.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }
}
