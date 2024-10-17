import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FilteringTextInputFormatter
import 'package:intl/intl.dart'; // For NumberFormat

class SindhIncomeTaxCalculator extends StatefulWidget {
  @override
  _SindhTaxCalculatorState createState() => _SindhTaxCalculatorState();
}

class _SindhTaxCalculatorState extends State<SindhIncomeTaxCalculator> {
  final TextEditingController _incomeController = TextEditingController();
  final numberFormat = NumberFormat('#,##0.00'); // Number formatting
  String _selectedYear = "2023-2024";
  double _annualIncome = 0.0;
  double _incomeTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sindh Agricultural Income Tax Calculator',
          style: TextStyle(color: Colors.white),
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
                    'Sindh Tax on Agricultural Income Calculator $_selectedYear',
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
                    'This is the latest Sindh Agricultural income calculator as per $_selectedYear budget presented by the government of Pakistan.',
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
                onTap: () => _showYearSelectionModal(context),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                        style: TextStyle(
                            fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                cursorColor: Colors.green, // Set cursor color to green
                controller: _incomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: "Enter Annual Income",
                  labelStyle: TextStyle(color: Colors.green[900]), // Label color
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Restrict input to digits
                ],
                onChanged: (value) {
                  setState(() {
                    _calculateTax();
                  });
                },
              ),
              SizedBox(height: 30),
              Center(
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
                          "Sindh Tax On Agricultural Income",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _buildTableRow(
                            "Agri. Income",
                            "${numberFormat.format(_annualIncome)} PKR",
                          ),
                          Divider(height: 0.5, color: Colors.green),
                          _buildTableRow(
                            "Tax on Agri. Income",
                            "${numberFormat.format(_incomeTax)} PKR",
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(String title, String value, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: Colors.green, width: 2.0),
          left: BorderSide(color: Colors.green, width: 2.0),
          right: BorderSide(color: Colors.green, width: 2.0),
          top: isLast ? BorderSide.none : BorderSide(color: Colors.green, width: 2.0),
        ),
        borderRadius: isLast
            ? BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        )
            : BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  void _calculateTax() {
    double incomeAmount = double.tryParse(_incomeController.text) ?? 0.0;
    double taxAmount = 0.0;

    if (_selectedYear == "2023-2024") {
      taxAmount = _calculateTax23to24(incomeAmount);
    } else {
      taxAmount = _calculateTax22to23(incomeAmount);
    }

    setState(() {
      _annualIncome = incomeAmount;
      _incomeTax = taxAmount;
    });
  }

  double _calculateTax23to24(double amount) {
    double taxAmount = 0;
    if (amount > 0 && amount < 1200000) {
      taxAmount = 0;
    } else if (amount >= 1200000 && amount < 2400000) {
      taxAmount = (amount - 1200000) * 0.05;
    } else if (amount >= 2400000 && amount <= 4800000) {
      taxAmount = (amount - 2400000) * 0.10 + 60000;
    } else if (amount > 4800000) {
      taxAmount = (amount - 4800000) * 0.15 + 300000;
    }
    return taxAmount;
  }

  double _calculateTax22to23(double amount) {
    double taxAmount = 0;
    if (amount > 0 && amount < 1200000) {
      taxAmount = 0;
    } else if (amount >= 1200000 && amount < 2400000) {
      taxAmount = (amount - 1200000) * 0.05;
    } else if (amount >= 2400000 && amount <= 4800000) {
      taxAmount = (amount - 2400000) * 0.10 + 60000;
    } else if (amount > 4800000) {
      taxAmount = (amount - 4800000) * 0.15 + 300000;
    }
    return taxAmount;
  }

  // Modal for Year Selection
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
}
