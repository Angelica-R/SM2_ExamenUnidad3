import 'package:appgym/view/formPhoto.view.dart';
import 'package:appgym/view/widgets/button.global.dart';
import 'package:flutter/material.dart';
import 'package:appgym/utils/global.colors.dart';
import 'package:get/get.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? selectedGender;
  String? selectedGoal;
  String? selectedLevel;

  final List<String> genders = ['Masculino', 'Femenino'];
  final List<String> goals = [
    'Bajar de peso',
    'Ganar masa muscular',
    'Mantenerse en forma'
  ];
  final List<String> levels = ['Principiante', 'Intermedio', 'Avanzado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text('Género:', style: TextStyle(color: GlobalColor.textColor)),
            DropdownButton<String>(
              value: selectedGender,
              hint: Text('Seleccione su género'),
              isExpanded: true,
              items: genders.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            const SizedBox(height: 15),
            Text('Altura (cm):',
                style: TextStyle(color: GlobalColor.textColor)),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ingrese su altura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Text('Peso (kg):', style: TextStyle(color: GlobalColor.textColor)),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ingrese su peso',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Text('Objetivo:', style: TextStyle(color: GlobalColor.textColor)),
            DropdownButton<String>(
              value: selectedGoal,
              hint: Text('Seleccione su objetivo'),
              isExpanded: true,
              items: goals.map((String goal) {
                return DropdownMenuItem<String>(
                  value: goal,
                  child: Text(goal),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGoal = newValue;
                });
              },
            ),
            const SizedBox(height: 15),
            Text('Nivel:', style: TextStyle(color: GlobalColor.textColor)),
            DropdownButton<String>(
              value: selectedLevel,
              hint: Text('Seleccione su nivel'),
              isExpanded: true,
              items: levels.map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLevel = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ButtonGlobal(
              text: 'Siguiente',
              onTap: () async {
                String height = heightController.text;
                String weight = weightController.text;
                print('Género: $selectedGender');
                print('Altura: $height');
                print('Peso: $weight');
                print('Objetivo: $selectedGoal');
                print('Nivel: $selectedLevel');

                Get.to(FormPhotoView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
