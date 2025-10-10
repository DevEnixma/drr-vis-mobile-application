import 'package:flutter/material.dart';

import '../../../data/models/home/product/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              product.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    Text(product.rating.rate.toString()),
                  ],
                ),
                Text('\$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${product.description}'),
          ),
        ],
      ),
    );
  }
}
