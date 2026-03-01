import 'package:flutter/material.dart';
import 'package:myapp/domain/usecases/get_random_number_usecase.dart';

class RandomNumberViewModel extends ChangeNotifier {
  final GetRandomNumberUseCase _getRandomNumberUseCase;

  RandomNumberViewModel(this._getRandomNumberUseCase);

  int? _randomNumber;
  int? get randomNumber => _randomNumber;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchRandomNumber() async {
    _isLoading = true;
    notifyListeners();

    try {
      final randomNumber = await _getRandomNumberUseCase();
      _randomNumber = randomNumber.value;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
