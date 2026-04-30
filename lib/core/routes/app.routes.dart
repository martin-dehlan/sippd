class AppRoutes {
  // Root
  static const String home = '/';

  // Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String chooseUsername = '/onboarding/username';
  static const String emailConfirmation = '/email-confirmation';
  static const String passwordRecovery = '/password-recovery';

  // Main tabs
  static const String wines = '/wines';
  static const String groups = '/groups';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String profileNotifications = '/profile/notifications';
  static const String wineCleanup = '/profile/wine-cleanup';

  // Wine
  static const String wineStats = '/wines/stats';
  static const String wineDetail = '/wines/:id';
  static const String wineAdd = '/wines/add';
  static const String wineEdit = '/wines/:id/edit';
  static String wineDetailPath(String id) => '/wines/$id';
  static String wineEditPath(String id) => '/wines/$id/edit';

  // Groups
  static const String groupDetail = '/groups/:id';
  static String groupDetailPath(String id) => '/groups/$id';

  // Friends
  static const String friends = '/friends';
  static const String friendProfile = '/friends/:id';
  static String friendProfilePath(String id) => '/friends/$id';

  // Paywall
  static const String paywall = '/paywall';
  static const String subscription = '/subscription';

  // Tastings
  static const String tastingCreate = '/groups/:groupId/tastings/new';
  static String tastingCreatePath(String groupId) =>
      '/groups/$groupId/tastings/new';
  static const String tastingDetail = '/tastings/:id';
  static String tastingDetailPath(String id) => '/tastings/$id';
  static const String tastingEdit = '/tastings/:id/edit';
  static String tastingEditPath(String id) => '/tastings/$id/edit';
}
