import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/address.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/adrres/list/client_adress_list_controller.dart';
import 'package:flutter_recolectando_innomine/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class clientAdressListPage extends StatelessWidget {
  ClientAdressListController con = Get.put(ClientAdressListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Mis Direcciones',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          _iconAddressCreate(),
        ],
      ),
      body: GetBuilder<ClientAdressListController>(
          builder: (value) => Stack(
                children: [
                  _textSelectAddress(),
                  _listAddress(context),
                ],
              )),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.createOrder(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            'SIGUIENTE',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _listAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: FutureBuilder(
          future: con.getAddress(),
          builder: (context, AsyncSnapshot<List<Address>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemBuilder: (_, index) {
                      return _radioSelectorAddress(
                        snapshot.data![index],
                        index,
                      );
                    });
              } else {
                return Center(
                  child: NoDataWidget(text: 'No hay direcciones'),
                );
              }
            } else {
              return Center(
                child: NoDataWidget(text: 'No hay direcciones'),
              );
            }
          }),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => con.SolicitudesPage(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.amber,
          size: 30,
        ),
      ),
    ));
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _iconDelete(address),
              Radio(
                value: index,
                groupValue: con.radioValue,
                onChanged: con.handleRadioValueChange,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? '',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address.neighborhood ?? '',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(address.lng.toString(), style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Divider(color: Colors.grey[400])
        ],
      ),
    );
  }

  Widget _iconDelete(Address address) {
    return IconButton(
        alignment: Alignment.bottomRight,
        onPressed: () => con.deleteItem(address),
        icon: Icon(
          Icons.delete,
          color: Colors.amber,
        ));
  }

  Widget _textSelectAddress() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30),
      child: Text(
        'Elige tu Ubicacion ',
        style: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconAddressCreate() {
    return IconButton(
        onPressed: () => con.goToAddressCreate(),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ));
  }
}
