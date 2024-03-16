import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:machinetest/features/auth/bloc/auth_bloc.dart';
import 'package:machinetest/features/auth/bloc/auth_event.dart';
import 'package:machinetest/features/auth/bloc/auth_state.dart';
import 'package:machinetest/features/auth/login_screen.dart';
import 'package:machinetest/features/product_management/add_product_screen.dart';
import 'package:machinetest/features/product_management/bloc/product_bloc.dart';
import 'package:machinetest/features/product_management/bloc/product_event.dart';
import 'package:machinetest/features/product_management/widgets/product_listing.dart';
import 'package:machinetest/features/product_management/widgets/search_bar.dart';
import 'package:machinetest/shared/utils/app_colors.dart';
import 'package:machinetest/shared/utils/app_utils.dart';
import 'package:machinetest/shared/widgets/app_loader.dart';
import 'package:machinetest/shared/widgets/text_widget.dart';
import 'bloc/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const FetchProducts());
    super.initState();
  }

  AppLoader loader = AppLoader();
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          title:
              TextWidget.semiBoldText(text: 'Products', color: AppColors.white),
          backgroundColor: AppColors.themeColor,
          actions: [
            BlocConsumer(
                bloc: BlocProvider.of<AuthenticationBloc>(context),
                listener: (c, o) {},
                builder: (context, AuthenticationState state) {
                  if (state is LogoutLoading) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      loader.show(context);
                    });
                  } else if (state is LogoutSuccess) {
                    loader.hide(context);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                          (route) => false);
                    });
                  } else if (state is LogoutFailure) {
                    loader.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: TextWidget.boldText(text: state.error)));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LogoutRequested());
                        },
                        child: const Icon(
                          Icons.logout,
                          color: AppColors.white,
                        )),
                  );
                }),
            const Gap(10),
          ]),
      body: Stack(
        children: [
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is FetchProductFailureState) {
                loader.hide(context);
                showSNackbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is FetchProductLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  loader.show(context);
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  loader.hide(context);
                });
              }
              if (state is FetchProductSuccessState) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 100),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    var item = state.products[index];
                    return ProductListing(
                      item: item,
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return SearchWidget(
                isSearchDone: context.read<ProductBloc>().isSearchDone,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddProductScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
