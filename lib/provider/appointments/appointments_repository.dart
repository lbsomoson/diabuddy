import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore firestore;

  AppointmentRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addAppointment(Appointment appointment) {
    return firestore
        .collection('appointments')
        .add(appointment.toJson(appointment));
    // return firestore
    //     .collection('appointments')
    //     .doc(appointment.appointmentId)
    //     .set(appointment.toJson(appointment));
  }

  Future<void> updateAppointment(
      Appointment appointment, String appointmentId) async {
    try {
      // retrieve the document
      DocumentSnapshot documentSnapshot =
          await firestore.collection('appointments').doc(appointmentId).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be updated from the existing data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;

        // merge the updated data with the existing data
        Map<String, dynamic> updatedData = appointment.toJson(appointment);
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await firestore
            .collection('appointments')
            .doc(appointmentId)
            .set(mergedData);
      }
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
  }

  Future<void> deleteAppointment(String appointmentId) {
    return firestore.collection('appointments').doc(appointmentId).delete();
  }

  // Stream<List<Appointment>> getAppointments(String userId) {
  //   print(
  //       "===================Fetching appointment for user: $userId===================");

  //   print("Fetching appointment for user: $userId");
  //   return firestore
  //       .collection('appointments')
  //       .where("userId", isEqualTo: userId)
  //       .snapshots()
  //       .map((snapshot) {
  //     print(
  //         "Appointments snapshot: ${snapshot.docs.length} documents fetched.");
  //     return snapshot.docs
  //         .map((doc) => Appointment.fromJson(doc.data()))
  //         .toList();
  //   });
  // }

  Stream<List<Appointment>> getAppointments(String userId) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // include the document ID when creating the Application object
        return Appointment.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
