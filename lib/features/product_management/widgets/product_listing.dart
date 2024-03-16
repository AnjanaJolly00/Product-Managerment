import 'package:flutter/material.dart';

import '../../../core/data/models/product_model.dart';
import '../../../shared/widgets/text_widget.dart';
import '../product_detail_screen.dart';

class ProductListing extends StatelessWidget {
  final Product item;
  const ProductListing({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: item)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 226, 238, 236)),
          child: item.name.isEmpty
              ? const SizedBox()
              : ListTile(
                  title: TextWidget.boldText(
                      text: item.name,
                      color: const Color.fromARGB(255, 75, 68, 68),
                      fontSize: 16),
                  trailing: TextWidget.regularText(
                      text: '₹ ${item.price.toString()}',
                      color: const Color.fromARGB(255, 75, 68, 68),
                      fontSize: 14),
                  subtitle: TextWidget.semiBoldText(
                      text: '${item.measurement} Units',
                      color: const Color.fromARGB(255, 75, 68, 68),
                      fontSize: 12),
                ),
        ),
      ),
    );
  }
}
