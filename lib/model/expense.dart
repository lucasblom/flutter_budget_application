/// This class is used to create an object of type Expense
class Expense{
  Expense(this._name, this._category, this._amount); 

  String get name => _name;
  String get category => _category;
  double get amount => _amount;


  final String _name;
  final String _category;
  final double _amount;
}
