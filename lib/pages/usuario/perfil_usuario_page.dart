import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/input_decoration.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';

class PerfilUsuarioPage extends StatelessWidget {
  const PerfilUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    final userService = Provider.of<UserService>(context);
    final userProvider = userService.userProvider;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 35,),
            const Center(
              child: Icon(
                Icons.person_pin,
                size: 160,
                color: Color(0xFF213A57),
              ),
            ),
            Text(
              userProvider.name,
              style: const TextStyle(
                fontSize: 30,
                color: Color(0xFF0B6477),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: userProvider.name,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration('Nombre', 'Escriba su nombre', Icons.person),
                      onChanged: (value) => userProvider.name = value,
                      validator: (value) { 
                        if (value != null && value.length >= 3) {
                          return null;
                        }
                        return 'El nombre debe tener al menos 3 caracteres';
                      },
                    ),
            const SizedBox(height: 30),
            TextFormField(
              initialValue: userProvider.email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Correo electrónico', 'Ejemplo juan.perez@gmail.com', Icons.alternate_email),
              onChanged: (value) => userProvider.email = value,
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
              initialValue: userProvider.password,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Contraseña', '******', Icons.lock_outline),
              onChanged: (value) => userProvider.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                }

                return 'La contraseña debe tener al menos 6 caracteres';
              },
            ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            userService.isLoading ? const IsLoading() 
            :
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {

                  userService.updateUser(userProvider).then((response) {

                    if (response['success']) {
                      popUp(context: context, title: 'Usuario actualizado', body: 'El perfil ha sido actualizado exitosamente', dialogType: 'success');
                    } else {
                      popUp(context: context, title: 'Error', body: response['message'], dialogType: 'warning');
                    }
                  }).catchError((error) {
                    popUp(context: context, title: 'Error', body: 'Error al registrar usuario', dialogType: 'error');
                  });
                 
                }
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF80ED99)),
                minimumSize: WidgetStatePropertyAll(Size(250, 50)),
              ),

              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
