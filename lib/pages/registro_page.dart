import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/user_model.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/input_decoration.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const SizedBox(height: 10),
            const Image(image: AssetImage('assets/logo.png')),
            _SignUpForm(),
            const SizedBox(height: 20),
            const Text('¿Ya tienes una cuenta?'),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text(
                'Inicia sesión',
                style: TextStyle(color: Color(0xFF14919B)),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    final userService = Provider.of<UserService>(context);

    User newUser = userService.getEmptyUser;

    if (userService.isLoading) return const IsLoading();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Nombre', 'Escriba su nombre', Icons.person),
              onChanged: (value) => newUser.name = value,
              validator: (value) { 
                if (value != null && value.length >= 3) {
                  return null;
                }
                return 'El nombre debe tener al menos 3 caracteres';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Correo electrónico', 'Ejemplo juan.perez@gmail.com', Icons.alternate_email),
              onChanged: (value) => newUser.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es válido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Contraseña', '******', Icons.lock_outline),
              onChanged: (value) => newUser.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                }

                return 'La contraseña debe tener al menos 6 caracteres';
              },
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(
                  value: "Estudiante",
                  child: Text("Estudiante"),
                ),
                DropdownMenuItem(
                  value: "Creador de contenido",
                  child: Text("Creador de contenido"),
                ),
              ],
              onChanged: (value) => newUser.rol = value == 'Estudiante' ? 0 : 1, 
              decoration: inputDecoration('Rol', 'Selecciona una opción', Icons.person),
              style: const TextStyle(color: Colors.black), // Color del texto de las opciones
              iconEnabledColor:const Color(0xFF14919B), // Color del icono de la flecha
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF213A57),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {

                  userService.signup(newUser).then((response) {

                    print(response);

                    if (response['success']) {

                      // popUp(context: context, title: 'Éxito', body: Text(response['message']));
                      Navigator.pushReplacementNamed(context, 'login');

                    } else {
                      popUp(context: context, title: 'Error', body: response['message'], dialogType: 'warning');
                    }
                  }).catchError((error) {
                    popUp(context: context, title: 'Error', body: 'Error al registrar usuario', dialogType: 'error');
                  });
                 
                }
                
              },
              child: const Text( 'Registrarse',style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
