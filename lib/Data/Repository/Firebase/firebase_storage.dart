import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  List playersList = [];
  List scoreList = [];
  List nameList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Players");

  Future getData(String username) async {
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          playersList.add(result.data());
        }
      });

      for (var score in playersList) {
        scoreList.add(score["score"]);
        nameList.add(score["name"]);
      }

      var temp = scoreList[nameList.indexOf(username)];
      scoreList = scoreList..sort();

      scoreList = sort_desc(scoreList);

      return scoreList.indexOf(temp) + 1;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> addValuestoFS(String docID, int score) {
    return collectionRef
        .doc(docID)
        //will edit the doc if already available or will create a new doc with this given ID
        .set(
          {"name": docID, "score": score},
          SetOptions(merge: true),
          // if set to 'false' then, only these given fields will be added to that doc
        )
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  sort_desc(List arrayVal) {
    List temp = [];
    for (var i = arrayVal.length - 1; i >= 0; i--) {
      temp.add(arrayVal[i]);
    }

    return temp;
  }
}
