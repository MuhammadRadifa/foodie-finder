enum NavigationRoute {
  home("/home"),
  detail("/detail"),
  settings("/settings"),
  search("/search"),
  favorite("/favorite");

  const NavigationRoute(this.route);
  final String route;
}
