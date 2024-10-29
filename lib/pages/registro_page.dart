import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Column(
              children: [
                const SizedBox(height: 10),
                const Image(image: AssetImage('assets/logo.png')),
                _LoginForm(),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '¿Ya tienes una cuenta?',
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text(
                'Inicia sesión',
                style: TextStyle(color: Color(0xFF14919B)),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  // const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      // key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF14919B),
                        width: 1.0), // Normal border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF14919B),
                        width: 2.0), // Border color when focused
                  ),
                  hintText: 'Ejemplo: juan.perez@gmail.com',
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.alternate_email_sharp,
                    color: Color(0xFF14919B),
                  )),
              // onChanged: (value) {  loginForm.email = value },
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es válido';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(0xFF14919B),
                      width: 1.0), // Normal border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(0xFF14919B),
                      width: 2.0), // Border color when focused
                ),
                hintText: '********',
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Color(0xFF14919B),
                ),
              ),
              // onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                }

                return 'La contraseña debe tener al menos 6 caracteres';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(
                  value: "Estudiante",
                  child: Text("Estudiante"),
                ),
                DropdownMenuItem(
                  value: "Creador de contenido",
                  child: Text("Creador de contenido"),
                ),
              ],
              onChanged: (value) {
                // Aquí puedes manejar el valor seleccionado
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(0xFF14919B),
                      width: 1.0), // Color del borde normal
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(0xFF14919B),
                      width: 2.0), // Color del borde al enfocar
                ),
                hintText: 'Selecciona una opción',
                labelText: 'Rol',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF14919B),
                ),
              ),
              style: TextStyle(
                  color: Colors.black), // Color del texto de las opciones
              iconEnabledColor:
                  Color(0xFF14919B), // Color del icono de la flecha
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              padding: EdgeInsets.all(20),
              color: Color(0xFF213A57),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              
              // onPressed: loginForm.isLoading
              //   ? null
              //   : () async {
              //     FocusScope.of(context).unfocus();
              //     if (!loginForm.isValidForm()) return;

              //     loginForm.isLoading = true;

              //     await Future.delayed(const Duration(seconds: 2));

              //     loginForm.isLoading = false;
              //     Navigator.pushReplacementNamed(context, 'home');
              //   }
              // ,
              child: Text(
                'Registrarse',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
