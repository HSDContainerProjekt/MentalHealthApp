class FriendRequest {
  final int friend1;
  final int friend2;
  final int status;

  const FriendRequest({
    required this.friend1,
    required this.friend2,
    required this.status,
  });

  factory FriendRequest.fromSqfliteDatabase(Map<String, dynamic> map) => FriendRequest(
        friend1: map['friend1']?.toInt() ?? 0,
        friend2: map['friend2']?.toInt() ?? 0,
        status: map['status']?.toInt() ?? 0,
      );

  String toString() {
    return 'Friendrequest{friend1: $friend1, friend2: $friend2, status: $status}';
  }
}
