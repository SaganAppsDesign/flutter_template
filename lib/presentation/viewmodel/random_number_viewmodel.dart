import 'package:myapp/domain/usecases/get_random_number_usecase.dart';
import 'package:myapp/core/presentation/base_viewmodel.dart';
import 'package:myapp/core/usecases/usecase.dart';

class RandomNumberViewModel extends BaseViewModel {
  final GetRandomNumberUseCase _getRandomNumberUseCase;

  RandomNumberViewModel(this._getRandomNumberUseCase);

  int? _randomNumber;
  int? get randomNumber => _randomNumber;

  Future<void> fetchRandomNumber() async {
    setLoading(true);
    clearError();

    final result = await _getRandomNumberUseCase(NoParams());

    result.fold(
      (failure) => setError(
        failure.message.isNotEmpty
            ? failure.message
            : 'Error fetching random number',
      ),
      (randomNumber) => _randomNumber = randomNumber.value,
    );

    setLoading(false);
  }
}
