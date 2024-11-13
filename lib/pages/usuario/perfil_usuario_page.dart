import 'package:flutter/material.dart';

class PerfilUsuarioPage extends StatelessWidget {
  const PerfilUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Center(
            child: Icon(
              Icons.person_pin,
              size: 160,
              color: Color(0xFF213A57),
            ),
          ),
          Text(
            "Editar",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF0B6477),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF14919B),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF14919B),
                            width: 2,
                          ),
                        ),
                        hintText: 'Ejemplo: juan.perez@gmail.com',
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.alternate_email_sharp,
                          color: Color(0xFF14919B),
                        ),
                      ),
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'El correo no es válido';
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF14919B),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF14919B),
                              width: 2,
                            ),
                          ),
                          hintText: '**********',
                          labelText: 'Contraseña:',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xFF14919B),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.length >= 6) return null;
                          return 'La contraseña debe tener al menos 6 caracteres';
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    // Eliminar el botón y la lógica de carga
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Guardar",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF80ED99)),
              minimumSize: WidgetStatePropertyAll(Size(250, 50)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Cancelar",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
              minimumSize: WidgetStatePropertyAll(Size(150, 50)),
            ),
          ),
        ],
      ),
    );
  }
}
