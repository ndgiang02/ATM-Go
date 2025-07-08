import 'dart:developer';

import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._locationRepository);
  final LocationRepositoryImpl _locationRepository;

  List<Location> _locations = [];
  List<Location> get locations => _locations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _hasLoaded = false;

  Future<void> getLocationNearest() async {
    if (_hasLoaded) return;

    _isLoading = true;
    notifyListeners();
    try {
      _locations = await _locationRepository.getLocationNearest(
        21.0227396,
        105.8369637,
      );
      _errorMessage = null;
      _hasLoaded = true;
    } catch (e) {
      _errorMessage = 'Không thể tải danh sách ngân hàng';
      log('$e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
