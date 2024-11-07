import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/widgets/input_decoration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 80),
          const SizedBox(height: 10),
          const Image(image: AssetImage('assets/logo.png')),
          _LoginForm(),
          const SizedBox( height: 50),
          const Text('¿Aún no tienes cuenta?'),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, 'registro'),
            child: const Text( 'Registrate', style: TextStyle(color: Color(0xFF14919B))),
          ),
          const SizedBox(height: 50)
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
              decoration: inputDecoration('Correo electrónico', 'Ejemplo: juan.perez@gmail.com', Icons.alternate_email),
              // onChanged: (value) {  loginForm.email = value },
              validator: (value)  {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'El correo no es válido';
              },
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration('Contraseña', '*****', Icons.lock_outline),
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
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF213A57),
              onPressed: () {
                Navigator.pushNamed(context, 'navigation');
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
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox( height: 20),
          ],
        ),
      ),
    );
  }
}
