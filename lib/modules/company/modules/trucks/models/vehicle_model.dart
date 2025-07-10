class VehicleModel {
  final String id;
  final String companyId;
  final String vehicleName;
  final String vehicleNumber;
  final String vehicleCapacity;
  final String vehicleFilled;
  final List<Map<String, dynamic>> logs;

  VehicleModel({
    required this.id,
    required this.companyId,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.vehicleCapacity,
    required this.vehicleFilled,
    required this.logs,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      vehicleName: json['vehicleName'] as String,
      vehicleNumber: json['vehicleNumber'] as String,
      vehicleCapacity: json['vehicleCapacity'] as String,
      vehicleFilled: json['vehicleFilled'] as String,
      logs: List<Map<String, dynamic>>.from(json['logs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'vehicleName': vehicleName,
      'vehicleNumber': vehicleNumber,
      'vehicleCapacity': vehicleCapacity,
      'vehicleFilled': vehicleFilled,
      'logs': logs,
    };
  }

  VehicleModel copyWith({
    String? id,
    String? companyId,
    String? vehicleName,
    String? vehicleNumber,
    String? vehicleCapacity,
    String? vehicleFilled,
    List<Map<String, dynamic>>? logs,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleCapacity: vehicleCapacity ?? this.vehicleCapacity,
      vehicleFilled: vehicleFilled ?? this.vehicleFilled,
      logs: logs ?? this.logs,
    );
  }

   VehicleModel addLog({
    required String logsMessage,
    required String createdDate,
    required String currentUserId,
    required String username,
    required String role,
  }) {
    final newLog = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'logsMessage': logsMessage,
      'createdDate': createdDate,
      'currentUserId': currentUserId,
      'username': username,
      'role': role,
    };

    return copyWith(logs: [...logs, newLog]);
  }
}
