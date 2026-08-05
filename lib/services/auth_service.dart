import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class AuthService {
  static const String baseUrl = 'https://api.example.com/v1'; // Replace with actual API

  final http.Client httpClient;
  String? _authToken;
  User? _currentUser;

  AuthService({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  /// Get current user
  User? get currentUser => _currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _authToken != null && _currentUser != null;

  /// Get current auth token
  String? get authToken => _authToken;

  /// Register new user
  Future<ApiResult<User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user'] ?? data);
        _authToken = data['token'];
        _currentUser = user;
        return ApiResult.success(user);
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid input data');
      } else if (response.statusCode == 409) {
        throw ValidationException(message: 'Email already exists');
      } else {
        throw ServerException(
          message: 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Registration failed: $e'));
    }
  }

  /// Login user
  Future<ApiResult<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user'] ?? data);
        _authToken = data['token'];
        _currentUser = user;
        return ApiResult.success(user);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Invalid credentials');
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'User not found');
      } else {
        throw ServerException(
          message: 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Login failed: $e'));
    }
  }

  /// Login with social account
  Future<ApiResult<User>> loginWithSocial({
    required String provider, // google, facebook, etc.
    required String accessToken,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/social-login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'provider': provider,
          'accessToken': accessToken,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user'] ?? data);
        _authToken = data['token'];
        _currentUser = user;
        return ApiResult.success(user);
      } else {
        throw ServerException(
          message: 'Social login failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Social login failed: $e'));
    }
  }

  /// Logout user
  Future<ApiResult<void>> logout() async {
    try {
      if (_authToken == null) {
        return ApiResult.success(null);
      }

      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 204) {
        _authToken = null;
        _currentUser = null;
        return ApiResult.success(null);
      } else {
        // Still clear local state even if server fails
        _authToken = null;
        _currentUser = null;
        return ApiResult.success(null);
      }
    } catch (e) {
      // Still clear local state
      _authToken = null;
      _currentUser = null;
      return ApiResult.error(NetworkException(message: 'Logout failed: $e'));
    }
  }

  /// Request password reset
  Future<ApiResult<void>> requestPasswordReset(String email) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return ApiResult.success(null);
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'User not found');
      } else {
        throw ServerException(
          message: 'Password reset request failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Password reset failed: $e'));
    }
  }

  /// Reset password with token
  Future<ApiResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'newPassword': newPassword,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return ApiResult.success(null);
      } else if (response.statusCode == 400) {
        throw ValidationException(message: 'Invalid or expired token');
      } else {
        throw ServerException(
          message: 'Password reset failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Password reset failed: $e'));
    }
  }

  /// Change password
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (_authToken == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/change-password'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return ApiResult.success(null);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message: 'Invalid current password');
      } else {
        throw ServerException(
          message: 'Change password failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Change password failed: $e'));
    }
  }

  /// Refresh auth token
  Future<ApiResult<String>> refreshToken() async {
    try {
      if (_authToken == null) {
        throw UnauthorizedException(message: 'No token to refresh');
      }

      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {
          'Authorization': 'Bearer $_authToken',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _authToken = data['token'];
        return ApiResult.success(_authToken!);
      } else if (response.statusCode == 401) {
        _authToken = null;
        _currentUser = null;
        throw UnauthorizedException(message: 'Token refresh failed');
      } else {
        throw ServerException(
          message: 'Token refresh failed',
          statusCode: response.statusCode,
        );
      }
    } on AppException catch (e) {
      return ApiResult.error(e);
    } catch (e) {
      return ApiResult.error(NetworkException(message: 'Token refresh failed: $e'));
    }
  }

  /// Set auth token (for restoring session)
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Clear auth data
  void clearAuth() {
    _authToken = null;
    _currentUser = null;
  }

  void dispose() {
    httpClient.close();
  }
}
