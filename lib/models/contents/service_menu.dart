import 'package:json_annotation/json_annotation.dart';
part 'service_menu.g.dart';

// class Service {
//   late int id;
//   late int agencyId;
//   late int serviceReferenceNumber;
//   late String name;
//   late List<ExtraField> extraFields;
//   late List<Matrix> matrix;
//   late bool favorite;
//   late Agency agency;

//   Service({
//     required this.id,
//     required this.agencyId,
//     required this.serviceReferenceNumber,
//     required this.name,
//     required this.extraFields,
//     required this.matrix,
//     required this.favorite,
//     required this.agency,
//   });

//   Service.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     agencyId = json['agency_id'];
//     serviceReferenceNumber = json['service_reference_number'] ?? '';
//     name = json['name'];
//     extraFields = json['extra_fields'];
//     matrix = json['matrix'];
//     favorite = json['favorite'];
//     agency = json['agency'];
//   }
// }

// class Matrix {}

// class ExtraField {}

// class Agency {
//   int? id;
//   String? name;
//   String? logoPath;

//   Agency({this.id, this.name, this.logoPath});

//   Agency.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     logoPath = json['logo_path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['logo_path'] = this.logoPath;
//     return data;
//   }
// }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ServiceMenu {
  ServiceMenu({
    required this.id,
    required this.agencyId,
    required this.serviceReferenceNumber,
    required this.name,
    required this.extraFields,
    required this.matrix,
    required this.favorite,
    required this.agency,
  });

  int id;
  int agencyId;
  String serviceReferenceNumber;
  String name;
  List<dynamic> extraFields;
  List<dynamic> matrix;
  bool favorite;
  Agency agency;

  factory ServiceMenu.fromJson(Map<String, dynamic> json) =>
      _$ServiceMenuFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceMenuToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Agency {
  Agency({
    required this.id,
    required this.name,
    required this.logoPath,
  });

  int id;
  String name;
  dynamic logoPath;

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}
