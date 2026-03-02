import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';

class RandomNumberScreen extends StatelessWidget {
  const RandomNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The ViewModel is now provided in main.dart via MultiProvider
    return const RandomNumberView();
  }
}

class RandomNumberView extends StatelessWidget {
  const RandomNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RandomNumberViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number MVVM'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Your Random Number is:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else
              Text(
                viewModel.randomNumber?.toString() ?? '?',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            if (viewModel.errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: viewModel.isLoading
                  ? null
                  : () => viewModel.fetchRandomNumber(),
              icon: const Icon(Icons.refresh),
              label: const Text('Generate New Number'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
