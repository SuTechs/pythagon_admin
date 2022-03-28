import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

class TransactionData extends BaseData<TransactionData> {
  TransactionData({
    this.amount,
    this.transactionType,
    this.isExpense,
    this.isCredit,
    this.img,
    this.assignmentId,
    this.teacherId,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.transactionRefName);

  double? amount;
  String? transactionType;
  bool? isExpense;
  bool? isCredit;
  String? img;
  String? assignmentId;
  String? teacherId;

  TransactionData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          amount: json['amount'] as double?,
          transactionType: json['transactionType'] as String?,
          isExpense: json['isExpense'] as bool?,
          isCredit: json['isCredit'] as bool?,
          img: json['img'] as String?,
          assignmentId: json['assignmentId'] as String?,
          teacherId: json['teacherId'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'amount': amount,
        'transactionType': transactionType,
        'isExpense': isExpense,
        'isCredit': isCredit,
        'img': img,
        'assignmentId': assignmentId,
        'teacherId': teacherId,
      };

  @override
  TransactionData fromJson(Map<String, dynamic> json) =>
      TransactionData.fromJson(json);
}
