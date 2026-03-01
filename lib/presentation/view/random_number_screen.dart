import 'package:flutter/material.dart';
import 'package:myapp/data/datasources/random_number_remote_data_source.dart';
import 'package:myapp/data/repositories_impl/random_number_repository_impl.dart';
import 'package:myapp/domain/usecases/get_random_number_usecase.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';
import 'package:provider/provider.dart';

class RandomNumberScreen extends StatelessWidget {
  const RandomNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RandomNumberViewModel(
        GetRandomNumberUseCase(
          RandomNumberRepositoryImpl(
            remoteDataSource: RandomNumberRemoteDataSourceImpl(),
          ),
        ),
      ),
      child: const RandomNumberView(),
    );
  }
}

class RandomNumberView extends StatelessWidget {
  const RandomNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RandomNumberViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number MVVM'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.randomNumber != null)
              Text(
                '${viewModel.randomNumber}',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            else
              const Text('Press the button to get a random number'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => viewModel.fetchRandomNumber(),
              child: const Text('Get Random Number'),
            ),
          ],
        ),
      ),
    );
  }
}
