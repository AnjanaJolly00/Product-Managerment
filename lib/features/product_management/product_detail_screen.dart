import 'package:flutter/material.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/data/models/product_model.dart'; // Assuming Product model is imported

class ProductDetailsScreen extends StatelessWidget {
  final Product product; // Assuming Product model is used

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget.semiBoldText(
                text: 'Product Name: ${product.name}', fontSize: 20),
            QrImageView(
              data: product.id,
              version: QrVersions.auto,
              size: 320,
              gapless: false,
              eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
