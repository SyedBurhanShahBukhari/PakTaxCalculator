import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FreelancerTaxCalculator extends StatefulWidget {
  @override
  _FreelancerTaxCalculatorState createState() =>
      _FreelancerTaxCalculatorState();
}

class _FreelancerTaxCalculatorState extends State<FreelancerTaxCalculator> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _yearlySalaryController = TextEditingController();
  String _salaryPeriod = 'monthly';
  String _selectedYear = '2023-2024';
  String _isRegistered = 'yes';
  int _monthlyIncome = 0;
  int _monthlyTax = 0;
  int _monthlyIncomeAfterTax = 0;
  int _yearlyIncome = 0;
  int _yearlyTax = 0;
  int _yearlyIncomeAfterTax = 0;

  @override
  void dispose() {
    _salaryController.dispose();
    _yearlySalaryController.dispose();
    super.dispose();
  }

  void _calculateTax() {
    int salaryAmount = int.tryParse(_salaryController.text) ?? 0;
    int taxAmount = 0;

    if (_selectedYear == '2023-2024' && _isRegistered == 'yes') {
      taxAmount = (salaryAmount * 0.0025).round();
    } else if (_selectedYear == '2023-2024' && _isRegistered == 'no') {
      taxAmount = (salaryAmount * 0.01).round();
    } else if (_selectedYear == '2022-2023' && _isRegistered == 'yes') {
      taxAmount = (salaryAmount * 0.0025).round();
    } else if (_selectedYear == '2022-2023' && _isRegistered == 'no') {
      taxAmount = (salaryAmount * 0.01).round();
    }

    setState(() {
      _monthlyIncome = salaryAmount;
      _monthlyTax = taxAmount;
      _monthlyIncomeAfterTax = salaryAmount - taxAmount;
      _yearlyIncome = salaryAmount * 12;
      _yearlyTax = taxAmount * 12;
      _yearlyIncomeAfterTax = (salaryAmount - taxAmount) * 12;
    });
  }

  void _calculateYearlyTax() {
    int yearlySalaryAmount = int.tryParse(_yearlySalaryController.text) ?? 0;
    int taxAmount = 0;

    if (_selectedYear == '2023-2024' && _isRegistered == 'yes') {
      taxAmount = (yearlySalaryAmount * 0.0025).round();
    } else if (_selectedYear == '2023-2024' && _isRegistered == 'no') {
      taxAmount = (yearlySalaryAmount * 0.01).round();
    } else if (_selectedYear == '2022-2023' && _isRegistered == 'yes') {
      taxAmount = (yearlySalaryAmount * 0.0025).round();
    } else if (_selectedYear == '2022-2023' && _isRegistered == 'no') {
      taxAmount = (yearlySalaryAmount * 0.01).round();
    }

    setState(() {
      _monthlyIncome = (yearlySalaryAmount / 12).round();
      _monthlyTax = (taxAmount / 12).round();
      _monthlyIncomeAfterTax =
          ((yearlySalaryAmount - taxAmount) / 12).round();
      _yearlyIncome = yearlySalaryAmount;
      _yearlyTax = taxAmount;
      _yearlyIncomeAfterTax = yearlySalaryAmount - taxAmount;
    });
  }

  void _showYearSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('2023-2024'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2023-2024";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('2022-2023'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2022-2023";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSalaryPeriodSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Monthly'),
                onTap: () {
                  setState(() {
                    _salaryPeriod = "monthly";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Yearly'),
                onTap: () {
                  setState(() {
                    _salaryPeriod = "yearly";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRegistrationStatusModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('PSEB Registered: Yes'),
                onTap: () {
                  setState(() {
                    _isRegistered = "yes";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('PSEB Registered: No'),
                onTap: () {
                  setState(() {
                    _isRegistered = "no";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Freelancer Tax Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Freelancer Tax Calculator $_selectedYear',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                      fontFamily: 'Overpass',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'This is the latest freelancer tax calculator as per $_selectedYear budget presented by the government of Pakistan.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                      fontFamily: 'Overpass',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => _showSalaryPeriodSelectionModal(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _salaryPeriod == "monthly" ? "Monthly" : "Yearly",
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _salaryPeriod == "monthly"
                    ? _salaryController
                    : _yearlySalaryController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Restrict to digits only
                ],
                decoration: InputDecoration(
                  labelText: _salaryPeriod == "monthly"
                      ? 'Your Monthly Salary'
                      : 'Your Yearly Salary',
                  labelStyle: TextStyle(
                    color: Colors.green[900], // Active label color
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                cursorColor: Colors.green, // Cursor (caret) color
                onChanged: (text) => _salaryPeriod == "monthly"
                    ? _calculateTax()
                    : _calculateYearlyTax(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showYearSelectionModal(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedYear,
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showRegistrationStatusModal(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isRegistered == "yes"
                            ? "PSEB Registered: Yes"
                            : "PSEB Registered: No",
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              _buildResultTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultTable() {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Monthly Tax Results',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _buildTableRow('Monthly Income', _monthlyIncome),
              _buildTableRow('Monthly Tax', _monthlyTax),
              _buildTableRow('Income After Tax', _monthlyIncomeAfterTax,
                  isLast: true),
            ],
          ),
        ),
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Yearly Tax Results',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _buildTableRow('Yearly Income', _yearlyIncome),
              _buildTableRow('Yearly Tax', _yearlyTax),
              _buildTableRow('Income After Tax', _yearlyIncomeAfterTax,
                  isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(String title, int amount, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: Colors.green, width: 2.0),
          left: BorderSide(color: Colors.green, width: 2.0),
          right: BorderSide(color: Colors.green, width: 2.0),
        ),
        borderRadius: isLast
            ? BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        )
            : BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
          Text(
            '${_formatNumber(amount)} PKR', // Display the formatted number with commas
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
        ],
      ),
    );
  }
}
