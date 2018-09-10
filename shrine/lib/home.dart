import 'package:flutter/material.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shrine"),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel: "menu",
            ),
            onPressed: () {}),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: "search",
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all),),
    );
  }
}
