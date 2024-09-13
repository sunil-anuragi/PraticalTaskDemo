import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Config/string.dart';
import '../../../provider/product_provider.dart';

class FilterPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final brands = provider.brands;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(AppStrings.brandfilter),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: brands
              .map((brand) => brand.name != ""
                  ? CheckboxListTile(
                      title: Text(brand.name),
                      value: provider.selectedBrands.contains(brand),
                      onChanged: (bool? selected) {
                        provider.toggleBrandSelection(brand);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  : Container())
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.close),
        ),
      ],
    );
  }
}
