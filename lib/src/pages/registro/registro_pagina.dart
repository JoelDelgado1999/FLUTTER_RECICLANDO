import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_recolectando_innomine/src/pages/registro/registro_controller.dart';
import 'package:get/get.dart';

class RegistroPagina extends StatelessWidget {
  RegisterController con = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttonBack(),
          Column(
            // POSICIONAR ELEMENTOS UNO DEBAJO DEL OTRO (VERTICAL)
            children: [
              _ImagenUsuario(context),
              _TextCargarImagen(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => con.gotoLogin(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.amber,
          size: 30,
        ),
      ),
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.green,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFielNombre(),
            _textFielApellido(),
            _textFielPhone(),
            _textFieldPassword(),
            _textFieldConfirPassword(),
            _botonRegistro(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            prefixIcon: Icon(Icons.email, color: Colors.green)),
      ),
    );
  }

  Widget _textFielNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.person, color: Colors.green)),
      ),
    );
  }

  Widget _textFielApellido() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Apellido ',
            prefixIcon: Icon(Icons.person_outline, color: Colors.green)),
      ),
    );
  }

  Widget _textFielPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Telefono ',
            prefixIcon:
                Icon(Icons.phone_android_outlined, color: Colors.green)),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contrase??a',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green,
            )),
      ),
    );
  }

  Widget _textFieldConfirPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar Contrase??a',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green,
            )),
      ),
    );
  }

  Widget _botonRegistro(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.register(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            'REGISTRARSE',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _ImagenUsuario(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<RegisterController>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : AssetImage('assets/img/usuario2.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
        'FORMULARIO DE REGISTRO',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _TextCargarImagen() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 45),
      child: Text(
        'CARGAR IMAGEN DE USUARIO',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
