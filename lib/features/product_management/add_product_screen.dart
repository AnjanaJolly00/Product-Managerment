import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:machinetest/features/product_management/bloc/product_bloc.dart';
import 'package:machinetest/features/product_management/bloc/product_event.dart';
import 'package:machinetest/features/product_management/product_screen.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/widgets/common_textfield.dart';
import 'package:machinetest/shared/widgets/main_button.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';
import '../../core/data/models/product_model.dart';
import '../../shared/utils/app_utils.dart';
import '../../shared/widgets/app_loader.dart';
import 'bloc/product_state.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController measurementController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          AppLoader loader = AppLoader();
          if (state is AddProductLoading) {
            loader.show(context);
          } else if (state is AddProductSuccessState) {
            loader.hide(context);
            showSNackbar(context, state.message);
            Future.delayed(const Duration(milliseconds: 10), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProductScreen()),
              );
            });
          } else if (state is AddProductFailureState) {
            showSNackbar(context, state.message);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: TextWidget.boldText(
                    text: 'Add Product',
                    fontSize: 18,
                    color: AppColors.textColor),
              ),
              const Gap(15),
              TextWidget.regularText(
                  text: 'Product Name',
                  fontSize: 14,
                  color: AppColors.textColor),
              const Gap(5),
              CommonTextField(hintText: '', controller: productNameController),
              const Gap(10),
              TextWidget.regularText(
                  text: 'Measurement',
                  fontSize: 14,
                  color: AppColors.textColor),
              CommonTextField(
                hintText: '',
                controller: measurementController,
                textInputType: TextInputType.number,
              ),
              const Gap(10),
              TextWidget.regularText(
                  text: 'Price', fontSize: 14, color: AppColors.textColor),
              CommonTextField(
                hintText: '',
                controller: priceController,
                textInputType: TextInputType.number,
              ),
              const Gap(20),
              MainButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<ProductBloc>(context).add(AddProduct(Product(
                      name: productNameController.text,
                      measurement: measurementController.text,
                      price: double.tryParse(priceController.text) ?? 0)));
                },
                text: "Add Product",
              )
            ],
          ),
        ),
      ),
    );
  }
}
