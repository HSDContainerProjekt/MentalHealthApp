class CounselingService {
  final int counselingServiceId;
  final int universityId;
  final String address;
  final String phoneNumber;

  CounselingService({
    required this.counselingServiceId,
    required this.universityId,
    required this.address,
    required this.phoneNumber,
  });

  factory CounselingService.fromJson(Map<String, dynamic> json) {
    return CounselingService(
      counselingServiceId: json['CounselingServiceID'],
      universityId: json['UniversityID'],
      address: json['Address'],
      phoneNumber: json['PhoneNumber'],
    );
  }
}