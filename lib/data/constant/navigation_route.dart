enum NavigationRoute {
  home("/home"),
  detail("/detail"),
  settings("/settings"),
  search("/search");

  const NavigationRoute(this.route);
  final String route;
}
