import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';

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
      final enteredCodeRoomUsers = roomRef.doc(roomCode).collection("users");
      enteredCodeRoomUsers.add(getUserId());
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
}
