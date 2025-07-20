import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/service/billing_service.dart';
import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';

class DonationSheet extends StatelessWidget {
  const DonationSheet._({super.key});

  // TODO Use Navigator
  static show(BuildContext context) async {
    context.read<BillingService>().getProducts();
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider.value(value: context.read<BillingService>(), child: DonationSheet._());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BillingService>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.p28, vertical: AppValues.p48),
      child: !viewModel.isFetchingProducts ? Column(
        spacing: AppValues.s12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  viewModel.productList.map(
                  (product) => ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(AppValues.r16),
                    ),
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    trailing: Text(product.priceString,
                        style: TextStyle(color: context.colorScheme.onSurface, fontSize: AppValues.fs16),
                    ),
                    onTap: () => viewModel.purchaseProduct(product),
                  ),
                ).toList(),
      ): _ProductsShimmer(),
    );
  }
}

class _ProductsShimmer extends StatelessWidget {
  const _ProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(134, 235, 235, 235),
      highlightColor: Color.fromARGB(113, 185, 185, 185),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 3,
        padding: EdgeInsets.zero,
        separatorBuilder: (_, _) => const SizedBox(height: AppValues.s12),
        itemBuilder: (_, _) => Container(
          padding: EdgeInsets.all(AppValues.p12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.r16),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: AppValues.s24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppValues.r4),
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppValues.p4),
                    ),
                    Container(
                      width: AppValues.s80,
                      height: AppValues.s16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppValues.r4),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppValues.s36),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppValues.r4),
                  color: Colors.white,
                ),
                width: AppValues.s40,
                height: AppValues.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

