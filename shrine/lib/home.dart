import 'package:flutter/material.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    return AsymmetricView(
        products: ProductsRepository.loadProducts(Category.all));
  }
}
