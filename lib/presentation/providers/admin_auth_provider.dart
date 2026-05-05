import 'package:flutter/material.dart';
import 'package:rehan_trader_website/services/admin_auth_service.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    _checkLoginStatus();
  }

  final AdminAuthService _service = AdminAuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isAdminLoggedIn = false;
  bool get isAdminLoggedIn => _isAdminLoggedIn;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Check login status on app start
  Future<void> _checkLoginStatus() async {
    _isAdminLoggedIn = await _service.isAdminLoggedIn();
    debugPrint(
      "*****Admin logged in (Provider _checkLoginStatus): $_isAdminLoggedIn*****",
    );
    notifyListeners();
  }

  Future<bool> attemptLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.loginAdmin(email, password);
      _isAdminLoggedIn = true;
      debugPrint(
        "*****Admin logged in (Provider attemptLogin): $_isAdminLoggedIn*****",
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        _showError(context, e.toString());
      }
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await _service.logoutAdmin();
    _isAdminLoggedIn = false;
    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
