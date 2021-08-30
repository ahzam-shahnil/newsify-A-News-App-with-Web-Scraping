// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:newsify/config/constant.dart';

// class ApiRepository {
//   // 1
//   // Create a CollectionReference called users that references the firestore collection
//   CollectionReference api = FirebaseFirestore.instance.collection('api');
//   // 2
//   Future<String> getApiDoc() async {
//     try {
//       var data = await api.doc('qdHARmA7OnEoOqiz6dVM').get();

//       return data['apiKey'];
//     } catch (e) {
//       return kApiKey;
//     }
//   }
// }
