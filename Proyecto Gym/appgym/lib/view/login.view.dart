import 'package:appgym/utils/global.colors.dart';
import 'package:appgym/view/form.view.dart';
import 'package:appgym/view/widgets/button.global.dart';
import 'package:appgym/view/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:appgym/view/register.view.dart';
import 'package:appgym/services/auth_service.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Inicie sesión con su cuenta',
                  style: TextStyle(
                    color: GlobalColor.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
                ButtonGlobal(
                  text: 'Iniciar Sesión',
                  onTap: () async {
                    bool success = await AuthService.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (success) {
                      int? userId = await AuthService.getUserId();
                      print("User ID: $userId");
                      Get.to(FormView());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error en las credenciales')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Navegar a la vista de registro
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterView(), // Instancia de la vista de registro
                        ),
                      );
                    },
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        color: GlobalColor.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
