// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentModel {
  final String paymentId;
  final double amount;
  final String sender;
  final String receiver;
  final String date;
  final bool isSent;
  final String senderId;
  final String receiverId;
  PaymentModel({
    required this.paymentId,
    required this.amount,
    required this.sender,
    required this.receiver,
    required this.date,
    required this.isSent,
    required this.senderId,
    required this.receiverId,
  });

  PaymentModel copyWith({
    String? paymentId,
    double? amount,
    String? sender,
    String? receiver,
    String? date,
    bool? isSent,
    String? senderId,
    String? receiverId,
  }) {
    return PaymentModel(
      paymentId: paymentId ?? this.paymentId,
      amount: amount ?? this.amount,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      date: date ?? this.date,
      isSent: isSent ?? this.isSent,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentId': paymentId,
      'amount': amount,
      'sender': sender,
      'receiver': receiver,
      'date': date,
      'isSent': isSent,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      paymentId: map['paymentId'] as String,
      amount: map['amount'] as double,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      date: map['date'] as String,
      isSent: map['isSent'] as bool,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
    );
  }
  PaymentModel.fromSnapshot(snapshot)
      : paymentId = snapshot.data()['paymentId'],
        amount = snapshot.data()['amount'],
        sender = snapshot.data()['sender'],
        receiver = snapshot.data()['receiver'],
        date = snapshot.data()['date'],
        isSent = snapshot.data()['isSent'],
        senderId = snapshot.data()['senderId'],
        receiverId = snapshot.data()['receiverId'];
  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(paymentId: $paymentId, amount: $amount, sender: $sender, receiver: $receiver, date: $date, isSent: $isSent, senderId: $senderId, receiverId: $receiverId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentModel &&
        other.paymentId == paymentId &&
        other.amount == amount &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.date == date &&
        other.isSent == isSent &&
        other.senderId == senderId &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    return paymentId.hashCode ^
        amount.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        date.hashCode ^
        isSent.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode;
  }
}
