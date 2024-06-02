class ApiConstants {
  // static const apiBaseUrl = "http://127.0.0.1:8000/api";
  // static const apiOrderBaseUrl = "http://127.0.0.1:8000/api/orders";
  // static const apiLoginUrl = "$apiBaseUrl/login";
  // static const apiForgotPassword = "$apiBaseUrl/forgot-password";
  // static const apiVerifyCOde = "$apiBaseUrl/";
  // static const apiResetPassword = "$apiBaseUrl/reset-password";
  // static const apiLogout = "$apiBaseUrl/logout";
  // static const apiGetProfileData = "$apiBaseUrl/profile";
  // static const apiGetMenus = "$apiBaseUrl/menus";
  // static const apiGetFloorTables = "$apiBaseUrl/floor-tables";
  // static const menuUrl = '$apiBaseUrl/menus';
  // static const apiCartUrl = '$apiBaseUrl/cart';
  // static const apiCartSetFloorTableUrl = '$apiCartUrl/floor-table';
  // static const apiCartSummaryUrl = '$apiCartUrl/summary';
  // static const apiPendingOrderUrl = '$apiOrderBaseUrl/pending';
  // static const apiOrderPlaceUrl = '$apiOrderBaseUrl/place';

  static const apiBaseUrl = "http://localhost:8000/api";
  static const apiOrderBaseUrl = "http://127.0.0.1:8000/api/kitchen/orders";
  static const apiHostBaseUrl = "http://localhost:8000/api/host/orders";

  static const apiLoginUrl = "$apiBaseUrl/login";
  static const apiAllOrderUrl = "$apiOrderBaseUrl/show";
  static const apiAllOrderCheckStatusUrl = "$apiOrderBaseUrl/changeStatus";
  static const apiHostReadyUrl = "$apiHostBaseUrl/show";
  static const apiProfileUrl = "$apiBaseUrl/profile";
  static const apiLogoutUrl = "$apiBaseUrl/logout";
}
