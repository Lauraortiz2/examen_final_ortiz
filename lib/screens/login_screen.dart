import 'package:examen_final_ortiz/providers/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),
              ),
              SizedBox(height: 50),            
            //Botón para redirigir a la página para registrarse en la app.
              MaterialButton(
                onPressed:
                    () => Navigator.pushReplacementNamed(context, 'register'),
                child: Text(
                  'Crear una cuenta nueva',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
}

class _LoginForm extends StatefulWidget {
 @override
  State<StatefulWidget> createState() => _LoginFormState();
}

  class _LoginFormState extends State<_LoginForm>{
        bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icon (Icons.alternate_email_outlined),
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value!) ? null : 'No es de tipo correo';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icon (Icons.lock_outline),
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña ha de tener 6 carácteres o más';
              },
            ),
            SizedBox(height: 30),
            Checkbox(
              semanticLabel: 'Recuerdame',
              value: _rememberMe, 
              onChanged: (bool? newValue) {
                          setState(() {
                            _rememberMe = newValue!;
                            if(_rememberMe){
                              loginForm.signInWithEmailAndPassword(loginForm.mailGuardado, loginForm.passwordGuardada);
                            }
                          });},),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Iniciar sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed:
                  loginForm.isLoading
                      ? null
                      : () async {
                        // Deshabilitamos el teclado
                        FocusScope.of(context).unfocus();

                        if (loginForm.isValidForm()) {
                          loginForm.isLoading = true;
                          loginForm.signInWithEmailAndPassword(
                            loginForm.email,
                            loginForm.password,
                          );
                          //Simulamos una petición
                          await Future.delayed(Duration(seconds: 2));
                          //Comprueba si el usuario está loggeado y si es así nos lleva a la pantalla de home, sino nos muestra un mensaje de error.
                          if (loginForm.isLogged) {
                            loginForm.isLoading = false;
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(loginForm.errorMessage)),
                            );
                            loginForm.isLoading = false;
                          }
                        }
                      },
            ),
          ],
        ),
      ),
    );
  }
}