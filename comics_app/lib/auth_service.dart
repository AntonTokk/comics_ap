import 'package:supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SupabaseClient supabase = SupabaseClient(
    'https://jevuhllrhtgpsjkmrouq.supabase.co', // Ваш URL Supabase
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpldnVobGxyaHRncHNqa21yb3VxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIxMDI5MzIsImV4cCI6MjA0NzY3ODkzMn0.ykjlR947B3k8KE2YbByRj3IAbKktkbrn2AEYqCqwTc4', // Ваш API Key
  );

  Future<User?> signUp(String email, String password) async {
    final response = await supabase.auth.signUp(email, password);
    if (response.error != null) {
      throw response.error!;
    }
    return response.user;
  }

  Future<User?> signIn(String email, String password) async {
    final response = await supabase.auth.signIn(email: email, password: password);
    if (response.error != null) {
      throw response.error!;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    return response.user;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<User?> getCurrentUser() async {
    return supabase.auth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();
    if (response.error != null) {
      throw response.error!;
    }
    return response.data;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}