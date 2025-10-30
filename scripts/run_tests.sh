#!/bin/bash

echo "=== Running Static Analysis ==="
dart analyze .

echo "=== Running Unit Tests ==="
flutter test test/calculator_test.dart
flutter test test/api_client_test.dart

echo "=== Running Widget Tests ==="
flutter test test/widget_test.dart

echo "=== Running Golden Tests ==="
flutter test test/golden_test.dart

echo "=== Running Integration Tests ==="
flutter test integration_test/app_test.dart

echo "=== All tests completed ==="