class Expense {
  final String name;
  final String category;
  final double amount;

  Expense(this.name, this.category, this.amount);

  // Create an Expense from a JSON object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      json['name'] as String,
      json['category'] as String,
      json['amount'] as double,
    );
  }

  // Convert an Expense to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'amount': amount,
    };
  }
}
