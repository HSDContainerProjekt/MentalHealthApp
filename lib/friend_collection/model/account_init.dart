class AccountInit {
  final String initAnimal;

  const AccountInit({
    required this.initAnimal,
  });

  Map<String, Object?> toMap() {
    return {
      'initAnimal': initAnimal,
    };
  }

  @override
  String toString() {
    return 'initAnimal{initAnimal: $initAnimal}';
  }
}
