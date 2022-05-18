import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/model/question.dart';

class RoomConnection {
  final db = FirebaseFirestore.instance;

  Map<String, String> getUserId() {
    final user = {"id": AuthenticationHelper().getUser()!.uid};
    return user;
  }

  Future<bool> createRoom({required String code}) async {
    final currentRoom = db.collection("rooms").doc(code);
    final name = {"name": code};
    currentRoom.set(name);
    final currentRoomUsers = currentRoom.collection("users");
    await currentRoomUsers.add(getUserId());
    return true;
  }

  Future<bool> addUserToRoom({required String roomCode}) async {
    // final roomRef = db.collection("rooms").doc(roomCode).collection("users");
    final roomRef = db.collection("rooms");
    final isThere = roomRef.where("name", isEqualTo: roomCode);
    final val = await isThere.get();
    if (val.size > 0) {
      final roomUsers = roomRef.doc(roomCode).collection("users");
      await roomUsers.add(getUserId());
      return true;
    } else {
      Get.snackbar("Room error",
          "Room with given code does not exist, please check the code or create a new one.",
          duration: const Duration(seconds: 5),
          barBlur: 0,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
  }

  Future<bool> addQuestionsToRoom(
      {required String roomCode, required Question questions}) async {
    final roomRef =
        db.collection("rooms").doc(roomCode).collection("questions");
    final snap = await roomRef.get();
    snap.docs.forEach((element) => roomRef.doc(element.id).delete());
    await roomRef.add(questions.toJson());
    return true;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRoomQuestions(
      {required String roomCode}) async {
    final roomRef =
        db.collection("rooms").doc(roomCode).collection("questions");
    final snap = await roomRef.get();
    return snap;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserCount(
      {required String roomCode}) {
    final roomRef = db.collection("rooms").doc(roomCode).collection("users");
    return roomRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuestionsPresent(
      {required String roomCode}) {
    final roomRef =
        db.collection("rooms").doc(roomCode).collection("questions");
    return roomRef.snapshots();
  }

  void updateScores(
      {required String code, required bool isCreator, required int score}) {
    final currentRoom = db.collection("rooms").doc(code);
    String currentPlayer = isCreator ? "player1" : "player2";
    final val = {currentPlayer: score};
    currentRoom.update(val);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> monitorScores(
      {required String roomCode}) {
    final roomRef = db.collection("rooms").doc(roomCode);
    return roomRef.snapshots();
  }

  Future<bool> deleteCurrentRoom({required String roomCode}) async {
    final roomRef =
        db.collection("rooms").doc(roomCode).collection("questions");
    roomRef.get().then((value) => {
          value.docs.forEach((element) {
            roomRef.doc(element.id).delete();
            final roomRef2 =
                db.collection("rooms").doc(roomCode).collection("users");
            roomRef2.get().then((value) => {
                  value.docs.forEach((element) {
                    roomRef2.doc(element.id).delete();
                    final roomRefNew = db.collection("rooms").doc(roomCode);
                    roomRefNew.delete();
                  })
                });
          })
        });

    return true;
  }
}
