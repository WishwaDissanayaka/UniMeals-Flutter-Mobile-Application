import 'package:cloud_firestore/cloud_firestore.dart';


////////////////////////////  Agents DataBASES  ////////////////////////////

// AGENT NOTES

class AgentNotesService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('AgentNotes');

  //Create
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesSream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesSream;
  }

  //Update: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete : Delete notes given a doc ID
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}





/////////////////////////////////  SELLER DATABASES //////////////////////////

//SELLER MENUS

class SellerMenusService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('SellerMenus');

  //Create
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesSream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesSream;
  }

  //Update: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete : Delete notes given a doc ID
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}



//sellerOrders

class SellerOrdersService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('SellerOrders');

  //Create
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesSream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesSream;
  }

  //Update: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete : Delete notes given a doc ID
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}




/////////////////////////////////  CUSTOMER DATABASES ////////////////

//s CUSTOMER ORDERS

class CustomerOrderService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('CustomerOrders');

  //Create
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesSream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesSream;
  }

  //Update: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete : Delete notes given a doc ID
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}


/////////////////////// AGENT /////////////////

class AgentOrderService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('AgentOrders');

  //Create
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesSream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesSream;
  }

  //Update: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete : Delete notes given a doc ID
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}