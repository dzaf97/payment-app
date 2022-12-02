import 'package:json_annotation/json_annotation.dart';
part 'service.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ServiceModel {
  ServiceModel({
    required this.id,
    required this.agencyId,
    required this.name,
    this.menuId,
    required this.serviceReferenceNumber,
    this.billTypeId,
    required this.serviceGroupId,
    required this.systemSupportingDocumentPath,
    required this.systemApprovalLetterDate,
    required this.systemApprovalLetterRef,
    required this.systemDescription,
    required this.systemLogo,
    required this.systemName,
    required this.productLabelDisplay,
    required this.matrix,
    required this.extraFields,
    this.fileExtensions,
    required this.maxFileSize,
    required this.refNoLabel,
    required this.allowCby,
    required this.cbyChargelines,
    required this.receiptType,
    required this.allowPartialPayment,
    required this.isSensitive,
    this.isInvoiceIGfmas,
    required this.allowThirdPartyPayment,
    this.thirdPartySearchTypes,
    required this.serviceMode,
    required this.integrationData,
    required this.serviceChargeData,
    required this.taxData,
    required this.discountData,
    required this.chargelineData,
    required this.status,
    required this.creatorId,
    required this.hasModified,
    required this.submittedAt,
    required this.approvalAgencyAt,
    required this.approvalAgencyBy,
    required this.approvalAgencyRemarks,
    required this.approvalBaRemarks,
    required this.approvalBaAt,
    required this.approvalBaBy,
    required this.approvalJanmFungsianAt,
    required this.approvalJanmFungsianRemarks,
    required this.approvalJanmFungsianBy,
    required this.approvalJanmTeknikalAt,
    required this.approvalJanmTeknikalRemarks,
    required this.approvalJanmTeknikalBy,
    required this.createdAt,
    required this.updatedAt,
    this.billType,
    required this.fundVote,
    required this.project,
    required this.accountCode,
    required this.programActivity,
  });

  int id;
  int agencyId;
  String name;
  int? menuId;
  String serviceReferenceNumber;
  int? billTypeId;
  dynamic serviceGroupId;
  dynamic systemSupportingDocumentPath;
  dynamic systemApprovalLetterDate;
  dynamic systemApprovalLetterRef;
  dynamic systemDescription;
  dynamic systemLogo;
  dynamic systemName;
  dynamic productLabelDisplay;
  List<DataMatrix> matrix;
  List<dynamic> extraFields;
  dynamic fileExtensions;
  dynamic maxFileSize;
  dynamic refNoLabel;
  int allowCby;
  String cbyChargelines;
  String receiptType;
  int allowPartialPayment;
  int isSensitive;
  int? isInvoiceIGfmas;
  String allowThirdPartyPayment;
  dynamic thirdPartySearchTypes;
  dynamic serviceMode;
  String integrationData;
  String serviceChargeData;
  String taxData;
  String discountData;
  String chargelineData;
  String status;
  int creatorId;
  int hasModified;
  dynamic submittedAt;
  dynamic approvalAgencyAt;
  dynamic approvalAgencyBy;
  dynamic approvalAgencyRemarks;
  dynamic approvalBaRemarks;
  dynamic approvalBaAt;
  dynamic approvalBaBy;
  dynamic approvalJanmFungsianAt;
  dynamic approvalJanmFungsianRemarks;
  dynamic approvalJanmFungsianBy;
  dynamic approvalJanmTeknikalAt;
  dynamic approvalJanmTeknikalRemarks;
  dynamic approvalJanmTeknikalBy;
  DateTime createdAt;
  DateTime updatedAt;
  BillType? billType;
  dynamic fundVote;
  dynamic project;
  dynamic accountCode;
  dynamic programActivity;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BillType {
  BillType({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  factory BillType.fromJson(Map<String, dynamic> json) =>
      _$BillTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BillTypeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DataMatrix {
  DataMatrix({
    required this.name,
    required this.basis,
    required this.matrix,
  });

  String name;
  int basis;
  List<List<dynamic>> matrix;

  factory DataMatrix.fromJson(Map<String, dynamic> json) =>
      _$DataMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$DataMatrixToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MatrixMatrixClass {
  MatrixMatrixClass({
    required this.unit,
    required this.title,
    this.classification,
  });

  String unit;
  String title;
  String? classification;

  factory MatrixMatrixClass.fromJson(Map<String, dynamic> json) =>
      _$MatrixMatrixClassFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMatrixClassToJson(this);
}
