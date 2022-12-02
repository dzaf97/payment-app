// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int,
      agencyId: json['agency_id'] as int,
      name: json['name'] as String,
      menuId: json['menu_id'] as int?,
      serviceReferenceNumber: json['service_reference_number'] as String,
      billTypeId: json['bill_type_id'] as int?,
      serviceGroupId: json['service_group_id'],
      systemSupportingDocumentPath: json['system_supporting_document_path'],
      systemApprovalLetterDate: json['system_approval_letter_date'],
      systemApprovalLetterRef: json['system_approval_letter_ref'],
      systemDescription: json['system_description'],
      systemLogo: json['system_logo'],
      systemName: json['system_name'],
      productLabelDisplay: json['product_label_display'],
      matrix: (json['matrix'] as List<dynamic>)
          .map((e) => DataMatrix.fromJson(e as Map<String, dynamic>))
          .toList(),
      extraFields: json['extra_fields'] as List<dynamic>,
      fileExtensions: json['file_extensions'],
      maxFileSize: json['max_file_size'],
      refNoLabel: json['ref_no_label'],
      allowCby: json['allow_cby'] as int,
      cbyChargelines: json['cby_chargelines'] as String,
      receiptType: json['receipt_type'] as String,
      allowPartialPayment: json['allow_partial_payment'] as int,
      isSensitive: json['is_sensitive'] as int,
      isInvoiceIGfmas: json['is_invoice_i_gfmas'] as int?,
      allowThirdPartyPayment: json['allow_third_party_payment'] as String,
      thirdPartySearchTypes: json['third_party_search_types'],
      serviceMode: json['service_mode'],
      integrationData: json['integration_data'] as String,
      serviceChargeData: json['service_charge_data'] as String,
      taxData: json['tax_data'] as String,
      discountData: json['discount_data'] as String,
      chargelineData: json['chargeline_data'] as String,
      status: json['status'] as String,
      creatorId: json['creator_id'] as int,
      hasModified: json['has_modified'] as int,
      submittedAt: json['submitted_at'],
      approvalAgencyAt: json['approval_agency_at'],
      approvalAgencyBy: json['approval_agency_by'],
      approvalAgencyRemarks: json['approval_agency_remarks'],
      approvalBaRemarks: json['approval_ba_remarks'],
      approvalBaAt: json['approval_ba_at'],
      approvalBaBy: json['approval_ba_by'],
      approvalJanmFungsianAt: json['approval_janm_fungsian_at'],
      approvalJanmFungsianRemarks: json['approval_janm_fungsian_remarks'],
      approvalJanmFungsianBy: json['approval_janm_fungsian_by'],
      approvalJanmTeknikalAt: json['approval_janm_teknikal_at'],
      approvalJanmTeknikalRemarks: json['approval_janm_teknikal_remarks'],
      approvalJanmTeknikalBy: json['approval_janm_teknikal_by'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      billType: json['bill_type'] == null
          ? null
          : BillType.fromJson(json['bill_type'] as Map<String, dynamic>),
      fundVote: json['fund_vote'],
      project: json['project'],
      accountCode: json['account_code'],
      programActivity: json['program_activity'],
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyId,
      'name': instance.name,
      'menu_id': instance.menuId,
      'service_reference_number': instance.serviceReferenceNumber,
      'bill_type_id': instance.billTypeId,
      'service_group_id': instance.serviceGroupId,
      'system_supporting_document_path': instance.systemSupportingDocumentPath,
      'system_approval_letter_date': instance.systemApprovalLetterDate,
      'system_approval_letter_ref': instance.systemApprovalLetterRef,
      'system_description': instance.systemDescription,
      'system_logo': instance.systemLogo,
      'system_name': instance.systemName,
      'product_label_display': instance.productLabelDisplay,
      'matrix': instance.matrix.map((e) => e.toJson()).toList(),
      'extra_fields': instance.extraFields,
      'file_extensions': instance.fileExtensions,
      'max_file_size': instance.maxFileSize,
      'ref_no_label': instance.refNoLabel,
      'allow_cby': instance.allowCby,
      'cby_chargelines': instance.cbyChargelines,
      'receipt_type': instance.receiptType,
      'allow_partial_payment': instance.allowPartialPayment,
      'is_sensitive': instance.isSensitive,
      'is_invoice_i_gfmas': instance.isInvoiceIGfmas,
      'allow_third_party_payment': instance.allowThirdPartyPayment,
      'third_party_search_types': instance.thirdPartySearchTypes,
      'service_mode': instance.serviceMode,
      'integration_data': instance.integrationData,
      'service_charge_data': instance.serviceChargeData,
      'tax_data': instance.taxData,
      'discount_data': instance.discountData,
      'chargeline_data': instance.chargelineData,
      'status': instance.status,
      'creator_id': instance.creatorId,
      'has_modified': instance.hasModified,
      'submitted_at': instance.submittedAt,
      'approval_agency_at': instance.approvalAgencyAt,
      'approval_agency_by': instance.approvalAgencyBy,
      'approval_agency_remarks': instance.approvalAgencyRemarks,
      'approval_ba_remarks': instance.approvalBaRemarks,
      'approval_ba_at': instance.approvalBaAt,
      'approval_ba_by': instance.approvalBaBy,
      'approval_janm_fungsian_at': instance.approvalJanmFungsianAt,
      'approval_janm_fungsian_remarks': instance.approvalJanmFungsianRemarks,
      'approval_janm_fungsian_by': instance.approvalJanmFungsianBy,
      'approval_janm_teknikal_at': instance.approvalJanmTeknikalAt,
      'approval_janm_teknikal_remarks': instance.approvalJanmTeknikalRemarks,
      'approval_janm_teknikal_by': instance.approvalJanmTeknikalBy,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'bill_type': instance.billType?.toJson(),
      'fund_vote': instance.fundVote,
      'project': instance.project,
      'account_code': instance.accountCode,
      'program_activity': instance.programActivity,
    };

BillType _$BillTypeFromJson(Map<String, dynamic> json) => BillType(
      id: json['id'] as int,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BillTypeToJson(BillType instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

DataMatrix _$DataMatrixFromJson(Map<String, dynamic> json) => DataMatrix(
      name: json['name'] as String,
      basis: json['basis'] as int,
      matrix: (json['matrix'] as List<dynamic>)
          .map((e) => e as List<dynamic>)
          .toList(),
    );

Map<String, dynamic> _$DataMatrixToJson(DataMatrix instance) =>
    <String, dynamic>{
      'name': instance.name,
      'basis': instance.basis,
      'matrix': instance.matrix,
    };

MatrixMatrixClass _$MatrixMatrixClassFromJson(Map<String, dynamic> json) =>
    MatrixMatrixClass(
      unit: json['unit'] as String,
      title: json['title'] as String,
      classification: json['classification'] as String?,
    );

Map<String, dynamic> _$MatrixMatrixClassToJson(MatrixMatrixClass instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'title': instance.title,
      'classification': instance.classification,
    };
