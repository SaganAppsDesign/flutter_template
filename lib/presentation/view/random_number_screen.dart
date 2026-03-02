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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Premium Template')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Illustration/Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  size: 64,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),

              // Main Content Card
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHighest.withAlpha(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: BorderSide(
                    color: colorScheme.outlineVariant.withAlpha(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        'Current Value',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (viewModel.isLoading)
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              strokeCap: StrokeCap.round,
                              color: colorScheme.primary,
                            ),
                          ),
                        )
                      else
                        Text(
                          viewModel.randomNumber?.toString() ?? '--',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 84,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.primary,
                            letterSpacing: -2,
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (viewModel.errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer.withAlpha(50),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            viewModel.errorMessage!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: viewModel.isLoading
                      ? null
                      : () => viewModel.fetchRandomNumber(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Generate Number'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Powered by Clean Architecture',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
