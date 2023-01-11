import 'package:flutter/material.dart';
import 'package:flutter_recolectando_innomine/src/models/category.dart';
import 'package:flutter_recolectando_innomine/src/models/product.dart';
import 'package:flutter_recolectando_innomine/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter_recolectando_innomine/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.categories.length,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBar(
                  flexibleSpace: Container(
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [_textFieldSearch(context), _iconShoppingBag()],
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.amber,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[600],
                    tabs: List<Widget>.generate(con.categories.length, (index) {
                      return Tab(
                        child: Text(con.categories[index].name ?? ''),
                      );
                    }),
                  ),
                ),
              ),
              body: TabBarView(
                children: con.categories.map((Category category) {
                  return FutureBuilder(
                      future: con.getProducts(
                          category.id ?? '1', con.productName.value),
                      builder:
                          (context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (_, index) {
                                  return _cardProduct(
                                      context, snapshot.data![index]);
                                });
                          } else {
                            return NoDataWidget(text: 'No hay productos');
                          }
                        } else {
                          return NoDataWidget(text: 'No hay productos');
                        }
                      });
                }).toList(),
              )),
        ));
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: con.items.value > 0
            ? Stack(
                children: [
                  IconButton(
                      onPressed: () => con.goToOrderCreate(),
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        size: 33,
                      )),
                  Positioned(
                      right: 4,
                      top: 10,
                      child: Container(
                        width: 16,
                        height: 16,
                        alignment: Alignment.center,
                        child: Text(
                          '${con.items.value}',
                          style: TextStyle(fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ))
                ],
              )
            : IconButton(
                onPressed: () => con.goToOrderCreate(),
                icon: Icon(
                  Icons.recycling_outlined,
                  size: 70,
                  color: Colors.white,
                )),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: con.onChangeText,
          decoration: InputDecoration(
              hintText: 'Buscar premio',
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              contentPadding: EdgeInsets.all(10)),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Puntos : ${product.price.toString()}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              trailing: Container(
                height: 80,
                width: 90,
                // padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1!)
                        : AssetImage('assets/img/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[300],
            indent: 37,
            endIndent: 37,
          )
        ],
      ),
    );
  }
}
