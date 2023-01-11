import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/order.dart';
import 'package:flutter_recolectando_innomine/src/models/premios.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/orders/detail/client_orders_detail_controller.dart';
import 'package:flutter_recolectando_innomine/src/utils/relative_time_util.dart';
import 'package:flutter_recolectando_innomine/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class ClientOrdersDetailPage extends StatelessWidget {
  ClientOrdersDetailController con = Get.put(ClientOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            height: con.order.status == 'EN CAMINO'
                ? MediaQuery.of(context).size.height * 0.5
                : MediaQuery.of(context).size.height * 0.50,
            // padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                _dataDate(),
                _dataDelivery(),
                _dataAddress(),
                _totalToPay(context),
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Order #${con.order.id}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(
            children: [_cardProduct(context)],
          ),
          /*body: ListView(
            children: [_cardProduct(context)],
          ),*/
          /* body: con.order.products!.isNotEmpty
      ? ListView(
        children: con.order.products!.map((Product product) {
         // return _cardProduct(product);
        }).toList(),
      )
      : Center(
          child: NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    )*/
        ));
  }

  Widget _dataDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Recolector y Telefono'),
        subtitle: Text(
            '${con.order.delivery?.name ?? 'No Asignado'} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? '###'}'),
        trailing: Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Direccion '),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Fecha de la solicitud'),
        subtitle: Text(
            '${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        trailing: Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Row(
        children: [
          _imageProduct(context),
          SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ${con.order.nombre_evidencia}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 7),
              Text(
                'Cantidad: ${con.order.cantidad_aprox}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageProduct1(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.order.evidencia != null
              ? NetworkImage(con.order.evidencia!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          radius: 90,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _imageProduct(contex) {
    return Container(
      height: 150,
      width: 200,

      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: con.order.evidencia != null
              ? NetworkImage(con.order.evidencia!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Container(
          margin: EdgeInsets.only(
              left: con.order.status == 'ENTREGADO' ? 30 : 37, top: 15),
          child: Row(
            mainAxisAlignment: con.order.status == 'ENTREGADO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              con.order.status == 'ENTREGADO' ? _Premios() : Container(),
              Text(
                'PUNTOS: ${con.total.value}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              con.order.status == 'EN CAMINO'
                  ? _buttonGoToOrderMap()
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _Premios() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          onPressed: () => con.goToPremios(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15), primary: Colors.amber),
          child: Text(
            'PREMIOS',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _buttonGoToOrderMap() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          onPressed: () => con.goToOrderMap(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15), primary: Colors.amber),
          child: Text(
            'RASTREAR SOLICITUD',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
