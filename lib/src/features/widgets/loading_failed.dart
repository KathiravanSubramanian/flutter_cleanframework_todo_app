import 'package:flutter/material.dart';

class LoadingFailed extends StatelessWidget {
  const LoadingFailed({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final themeCxt = Theme.of(context);
    double height = 20.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Icon(
                IconData(0xf0187, fontFamily: 'MaterialIcons'),
                size: 150,
              ),
            ),
            SizedBox(height: height),
            Text(
              'Unable to connect to server. Check your network connections or try again later.',
              style: themeCxt.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                style: themeCxt.outlinedButtonTheme.style,
                onPressed: onRetry,
                child: Text('Retry', style: themeCxt.textTheme.titleMedium),
              ),
            ),
            SizedBox(height: height + 40),
          ],
        ),
      ),
    );
  }
}