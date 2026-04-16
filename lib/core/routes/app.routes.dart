class AppRoutes {
  // Root
  static const String home = '/';

  // Auth
  static const String login = '/login';

  // Main tabs
  static const String wines = '/wines';
  static const String groups = '/groups';
  static const String profile = '/profile';

  // Wine
  static const String wineDetail = '/wines/:id';
  static const String wineAdd = '/wines/add';
  static String wineDetailPath(String id) => '/wines/$id';

  // Groups
  static const String groupDetail = '/groups/:id';
  static String groupDetailPath(String id) => '/groups/$id';
}
