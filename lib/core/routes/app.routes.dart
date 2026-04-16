class AppRoutes {
  // Root
  static const String home = '/';

  // Auth
  static const String login = '/login';
  static const String chooseUsername = '/onboarding/username';

  // Main tabs
  static const String wines = '/wines';
  static const String groups = '/groups';
  static const String profile = '/profile';

  // Wine
  static const String wineDetail = '/wines/:id';
  static const String wineAdd = '/wines/add';
  static String wineDetailPath(String id) => '/wines/$id';

  // Scanner
  static const String scan = '/scan';
  static const String scanResult = '/scan/result';
  static const String scanLabel = '/scan/label';

  // Groups
  static const String groupDetail = '/groups/:id';
  static String groupDetailPath(String id) => '/groups/$id';

  // Friends
  static const String friends = '/friends';
  static const String friendProfile = '/friends/:id';
  static String friendProfilePath(String id) => '/friends/$id';

  // Tastings
  static const String tastingCreate = '/groups/:groupId/tastings/new';
  static String tastingCreatePath(String groupId) =>
      '/groups/$groupId/tastings/new';
  static const String tastingDetail = '/tastings/:id';
  static String tastingDetailPath(String id) => '/tastings/$id';
}
