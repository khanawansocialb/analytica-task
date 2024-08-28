import 'package:flutter/material.dart';

import '../service/quote.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: QuoteService.getQuote(), 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Oops: ${snapshot.error}'); 
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              snapshot.data!,
              style:
                  const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const Text('No Quote Available'); // No data state
        }
      },
    );
  }
}
