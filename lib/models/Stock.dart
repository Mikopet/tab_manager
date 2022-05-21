/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Stock type in your schema. */
@immutable
class Stock extends Model {
  static const classType = const _StockModelType();
  final String id;
  final String? _product_id;
  final int? _amount;
  final int? _purchased_price;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get product_id {
    try {
      return _product_id!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get amount {
    try {
      return _amount!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get purchased_price {
    return _purchased_price;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Stock._internal({required this.id, required product_id, required amount, purchased_price, createdAt, updatedAt}): _product_id = product_id, _amount = amount, _purchased_price = purchased_price, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Stock({String? id, required String product_id, required int amount, int? purchased_price}) {
    return Stock._internal(
      id: id == null ? UUID.getUUID() : id,
      product_id: product_id,
      amount: amount,
      purchased_price: purchased_price);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Stock &&
      id == other.id &&
      _product_id == other._product_id &&
      _amount == other._amount &&
      _purchased_price == other._purchased_price;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Stock {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("product_id=" + "$_product_id" + ", ");
    buffer.write("amount=" + (_amount != null ? _amount!.toString() : "null") + ", ");
    buffer.write("purchased_price=" + (_purchased_price != null ? _purchased_price!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Stock copyWith({String? id, String? product_id, int? amount, int? purchased_price}) {
    return Stock._internal(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      amount: amount ?? this.amount,
      purchased_price: purchased_price ?? this.purchased_price);
  }
  
  Stock.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _product_id = json['product_id'],
      _amount = (json['amount'] as num?)?.toInt(),
      _purchased_price = (json['purchased_price'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'product_id': _product_id, 'amount': _amount, 'purchased_price': _purchased_price, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "stock.id");
  static final QueryField PRODUCT_ID = QueryField(fieldName: "product_id");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField PURCHASED_PRICE = QueryField(fieldName: "purchased_price");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Stock";
    modelSchemaDefinition.pluralName = "Stocks";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Stock.PRODUCT_ID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Stock.AMOUNT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Stock.PURCHASED_PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _StockModelType extends ModelType<Stock> {
  const _StockModelType();
  
  @override
  Stock fromJson(Map<String, dynamic> jsonData) {
    return Stock.fromJson(jsonData);
  }
}