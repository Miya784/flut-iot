class UserData {
  final int userId;
  final String username;
  final ClientData client;

  UserData(
      {required this.userId, required this.username, required this.client});
}

class ClientData {
  final int id;
  final int userId;
  final String createdAt;
  final String updatedAt;

  ClientData(
      {required this.id,
      required this.userId,
      required this.createdAt,
      required this.updatedAt});
}
