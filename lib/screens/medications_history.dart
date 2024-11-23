import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicationHistory extends StatefulWidget {
  const MedicationHistory({super.key});

  @override
  State<MedicationHistory> createState() => _MedicationHistoryState();
}

Widget _displayMedicationHistory(BuildContext context, String id) {
  return BlocBuilder<MedicationBloc, MedicationState>(
    builder: (context, state) {
      if (state is MedicationLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MedicationLoaded) {
        if (state.medications.isEmpty) {
          return const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text2Widget(text: "No previous medicine yet", style: 'body2'))]),
          );
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.medications.length,
          itemBuilder: (context, index) {
            MedicationIntake medication = state.medications[index];
            medication.medicationId = state.medications[index].medicationId;
            if (medication.isActive == false) {
              return CardWidget(
                leading: FontAwesomeIcons.pills,
                callback: () {},
                title: medication.name,
                subtitle: medication.time.join(", "),
              );
            }
            return const SizedBox.shrink();
          },
        );
      } else {
        return const Center(
          child: Text("Error encountered!"),
        );
      }
    },
  );
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
