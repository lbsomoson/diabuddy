import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medication_provider.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicationHistory extends StatefulWidget {
  const MedicationHistory({super.key});

  @override
  State<MedicationHistory> createState() => _MedicationHistoryState();
}

Widget _displayMedicationHistory(BuildContext context, String id) {
  return FutureBuilder(
      future: context.watch<MedicationProvider>().getInactiveMedications(id),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              MedicationIntake medication = snapshot.data[index] as MedicationIntake;
              return CardWidget(
                leading: FontAwesomeIcons.pills,
                callback: () {},
                title: medication.name,
                subtitle: medication.time.join(", "),
              );
            },
          );
        } else {
          return const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text2Widget(text: "No medicines yet", style: 'body2'))]),
          );
        }
      });
}

class _MedicationHistoryState extends State<MedicationHistory> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication History"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [_displayMedicationHistory(context, user!.uid)],
            ),
          ),
        ),
      ),
    );
  }
}
