import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class InquiryRepository {
  FirebaseFirestore _firestore;

  InquiryRepository({@required FirebaseFirestore firestore}) {
    this._firestore = firestore;
  }

  Future<void> reportMissingProduct(String productName) async {
    final bool inquiryExists = await _firestore
        .collection('inquiries')
        .where('productName', isEqualTo: productName)
        .get()
        .then((snap) => snap.docs.isNotEmpty);

    if (inquiryExists) return null;

    return _firestore.collection('inquiries').doc().set({
      'productName': productName,
      'date': Timestamp.fromDate(DateTime.now()),
    });
  }
}
