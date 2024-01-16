import 'package:flutter/material.dart';

class CardListPaymentWidget extends StatefulWidget {
  const CardListPaymentWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardListPaymentWidgetState createState() => _CardListPaymentWidgetState();
}

class _CardListPaymentWidgetState extends State<CardListPaymentWidget> {
  final List<String> paymentOptions = [
    'Credit Card',
    'Debit Card',
    'PayPal',
    'Google Pay',
    'Apple Pay',
  ];

  int selectedCardIndex = -1; // Default: No card selected

  @override
  Widget build(BuildContext context) {

     return ListView.builder(
        itemCount: paymentOptions.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: selectedCardIndex == index
                ? Colors.blue // Change color for selected card
                : null,
            child: ListTile(
              title: Text(paymentOptions[index]),
              onTap: () {
                // Handle payment option selection
                _handlePaymentOptionSelected(index);
              },
            ),
          );
        },
      );

  }

  void _handlePaymentOptionSelected(int selectedIndex) {
    // Update the selected card index
    setState(() {
      selectedCardIndex = selectedIndex;
    });

    // // Implement your logic when a payment option is selected
    // print('Selected payment option: ${paymentOptions[selectedIndex]}');
    // Add navigation or other logic as needed
  }
}
