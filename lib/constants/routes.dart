abstract class Routes {
  //!----> Authentication
  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const refresh = '/auth/refresh';
  static const register = '/auth/register';
  static const forgotPassword = '/auth/forgot-password';
  static const updatePassword = '/auth/update-password';

  //!----> User
  static const userProfile = '/profile';
  static const userProfileEdit = '/profile/edit';
  static const userProfileSetting = '/profile/setting';

  //! ----> Pages
  static const home = '/';
  static const dashboard = '/dashboard';
}
