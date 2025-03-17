class EmergencyAmbulance {
  final int ambulanceId;
  final int cityId;
  final String address;
  final String phoneNumber;

  EmergencyAmbulance({
    required this.ambulanceId,
    required this.cityId,
    required this.address,
    required this.phoneNumber,
  });

  factory EmergencyAmbulance.fromJson(Map<String, dynamic> json) {
    return EmergencyAmbulance(
      ambulanceId: json['AmbulanceID'],
      cityId: json['CityID'],
      address: json['Address'],
      phoneNumber: json['PhoneNumber'],
    );
  }
}