import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/register_screen.dart';

void main() {
  test('isStrongPassword returns true for a strong password', () {
    expect(isStrongPassword("StrongPass123!"), true);
  });

  test('isStrongPassword returns false for a weak password', () {
    expect(isStrongPassword("weakpass"), false);
  });

  test('isStrongPassword returns false for a numeric password', () {
    expect(isStrongPassword("12345678"), false);
  });

  test('isStrongPassword returns true for a password with uppercase, lowercase, digit, and special char', () {
    expect(isStrongPassword("ABCdef123!"), true);
  });

  test('isStrongPassword returns false for a password with insufficient length', () {
    expect(isStrongPassword("Short!1"), false);
  });

  test('isStrongPassword returns false for a password with excessive length', () {
    expect(isStrongPassword("a" * 100), false);
  });
}
