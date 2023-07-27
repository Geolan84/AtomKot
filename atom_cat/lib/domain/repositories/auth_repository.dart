import 'package:atom_cat/domain/api_client/api_client.dart';
import 'package:atom_cat/domain/data_providers/session_data_provider.dart';

class AuthRepository {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final token = await _sessionDataProvider.getToken();
    final isAuth = token != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final result = await _apiClient.auth(email: login, password: password);
    await _sessionDataProvider.saveToken(result["token"]);
    await _sessionDataProvider.saveUserId(result["user_id"]);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearToken();
    await _sessionDataProvider.clearUserId();
  }
}