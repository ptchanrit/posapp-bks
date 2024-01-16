import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_ordering/main.dart';

class ProductMenuCard extends StatelessWidget {
  final String productName;
  final double price;
  final int imageId; // Replace this with a network image URL if needed
  final double height;
  const ProductMenuCard(
      {super.key,
      required this.productName,
      required this.price,
      required this.imageId,
      required this.height});

  @override
  Widget build(BuildContext context) {
    final isSelected =
        Provider.of<MenuProvider>(context).selectedMenus.contains(productName);

    return Card(
      elevation: isSelected ? 8.0 : 2.0,
      color: isSelected ? Colors.green[200] : Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (isSelected)
          //   const Icon(Icons.check, color: Colors.green, size: 24.0),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(
              'https://picsum.photos/300/300/?image=$imageId',
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 1.0),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${price.toStringAsFixed(2)} บาท',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductMenuGrid extends StatelessWidget {
  final double heightSize;

  const ProductMenuGrid({super.key, required this.heightSize});

  @override
  Widget build(BuildContext context) {
    final selectedMenus = Provider.of<MenuProvider>(context).selectedMenus;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        final menuName = 'สินค้า ${index + 1}';
        final isSelected = selectedMenus.contains(menuName);
        final imageId = index + 1;
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              Provider.of<MenuProvider>(context, listen: false)
                  .removeSelectedMenu(menuName);
            } else {
              Provider.of<MenuProvider>(context, listen: false)
                  .addSelectedMenu(menuName);
            }
          },
          child:
              // Use your ProductMenuCard widget here with the necessary modifications
              ProductMenuCard(
                  productName: menuName,
                  price: 19.99 + index * 5.0,
                  imageId: imageId,
                  height: heightSize),
          // Add an indicator for selected state
        );
      },
    );
  }
}
