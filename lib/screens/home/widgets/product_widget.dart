import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/product/product_bloc.dart';
import '../../../utils/widgets/custom_loading.dart';
import 'product_card.dart';

class Product extends StatelessWidget {
  Product(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoadingState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomLoading.showLoadingDialog(context, Theme.of(context).colorScheme.primary);
            });
          } else if (state is ProductLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomLoading.dismissLoadingDialog(context);
            });
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              context.read<ProductBloc>().add(ProductFetchEvent(''));
            }
            if (state is ProductLoadedState) {
              var items = state.products;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ProductCard(
                    product: item,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
