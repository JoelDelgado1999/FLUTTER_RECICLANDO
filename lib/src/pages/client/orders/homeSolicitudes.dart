import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/orders/client_ordes_create_controller.dart';
import 'package:flutter_recolectando_innomine/src/widgets/background.dart';
import 'package:get/get.dart';

class HomeSolicitudes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Imagen  assets/img/login.png
        Image(image: AssetImage('assets/img/home.png')),

        // Title
        Title(),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
            child: Text(
                'La gestión de los residuos tiene importantes implicaciones de salud pública, ya que es uno de los dos principales portadores y propagadores de enfermedades infecciosas (el otro portador es el agua). Los residuos que se incineran o se eliminan en sitios no controlados pueden contaminar el aire, la tierra y el agua. Una gestión ineficaz de residuos sólidos genera una mala impresión en inversionistas y turistas, lo que repercute en la pérdida de reputación y oportunidades de inversión.')),

        // Button Section
        ButtonSection(),

        // Description
      ],
    ));
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INNOMINE S.A',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('derechos reservados',
                  style: TextStyle(color: Colors.black45)),
            ],
          ),
          Expanded(child: Container()),
          Icon(Icons.star, color: Colors.red),
          Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              onPressed: () => Navigator.pushNamed(
                  context, '/client/solicitudes/solicitudesPage'),
              icon: const Icon(
                Icons.loop,
                size: 50,
                color: Colors.amber,
              ),
              label: Text(
                'Recicla ahora',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          this.icon,
          color: Colors.amber,
          size: 30,
        ),
        Text(this.text, style: TextStyle(color: Colors.black))
      ],
    );
  }
}
