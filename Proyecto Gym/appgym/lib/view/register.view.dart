import 'package:appgym/utils/global.colors.dart';
import 'package:appgym/view/login.view.dart';
import 'package:appgym/view/widgets/button.global.dart';
import 'package:appgym/view/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:appgym/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Logo',
                    style: TextStyle(
                      color: GlobalColor.mainColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Crea tu cuenta',
                  style: TextStyle(
                    color: GlobalColor.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                // Name Input
                TextFormGlobal(
                  controller: nameController,
                  text: 'Nombres',
                  obscure: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                // Last Name Input
                TextFormGlobal(
                  controller: lastNameController,
                  text: 'Apellidos',
                  obscure: false,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                // Email Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Correo electrónico',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                // Password Input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Contraseña',
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                // Repeat Password Input
                TextFormGlobal(
                  controller: repeatPasswordController,
                  text: 'Repita Contraseña',
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                ButtonGlobal(
                  text: 'Registrarse',
                  onTap: () async {
                    if (passwordController.text ==
                        repeatPasswordController.text) {
                      bool success = await AuthService.register(
                        nombre: nameController.text,
                        apellido: lastNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      if (success) {
                        // Redirigir a la vista de inicio de sesión o mostrar un mensaje de éxito
                        Get.to(LoginView());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registro exitoso')));
                      } else {
                        // Mostrar mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error en el registro')),
                        );
                      }
                    } else {
                      // Contraseñas no coinciden
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Las contraseñas no coinciden')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
