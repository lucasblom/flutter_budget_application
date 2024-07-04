class Budget {
  final double amount;

  Budget(this.amount);

  // Create a Budget from a JSON object
  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      json['amount'] as double,
    );
  }

  // Convert a Budget to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
