// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/common_textfield.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, this.isSearchDone = false});
  final bool isSearchDone;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: CommonTextField(
        onChanged: (val) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (val.isEmpty) {
              context.read<ProductBloc>().add(const FetchProducts());
            } else {
              context.read<ProductBloc>().add(SearchProducts(val));
            }
          });
        },
        hintText: 'Search',
        controller: searchController,
        suffixIcon: widget.isSearchDone
            ? InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchController.clear();
                  BlocProvider.of<ProductBloc>(context)
                      .add(const FetchProducts());
                },
                child: const Icon(Icons.close))
            : InkWell(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  var result = await BarcodeScanner.scan();

                  BlocProvider.of<ProductBloc>(context)
                      .add(FetchProductDetails(result.rawContent));
                },
                child: const Icon(
                  Icons.qr_code_scanner_outlined,
                ),
              ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
