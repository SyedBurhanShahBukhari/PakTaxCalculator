import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WithholdingTaxCalculator extends StatefulWidget {
  @override
  _TaxCalculatorState createState() => _TaxCalculatorState();
}

class _TaxCalculatorState extends State<WithholdingTaxCalculator> {
  final TextEditingController _brokerIncomeController = TextEditingController();

  String _selectedYear = "2023-2024";
  String _selectedFilerStatus = "filerYes";
  String _selectedPersonType = "valueOne";

  double _annualFunds = 0.0;
  double _annualFundsTax = 0.0;

  // New data formatting method
  String _formatNumber(double number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withholding Tax on Brokerage',
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
                    'Withholding Tax On Brokerage & Commission Tax Calculator $_selectedYear',
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
                    'This is latest withholding tax on brokerage & commission tax calculator as per $_selectedYear budget presented by government of Pakistan.',
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
              _buildInputField(
                controller: _brokerIncomeController,
                labelText: "Enter Brokerage / Commission Income",
                onChanged: (value) => _calculateTax(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showYearSelectionModal(context),
                child: _buildDropdownContainer(_selectedYear),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showFilerStatusModal(context),
                child: _buildDropdownContainer(_getFilerStatusDescription(_selectedFilerStatus)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showPersonTypeModal(context),
                child: _buildDropdownContainer(_getPersonTypeDescription(_selectedPersonType)),
              ),
              SizedBox(height: 30),
              _buildResultsTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownContainer(String text) {
    return Container(
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
            text,
            style: TextStyle(fontSize: 18, color: Colors.green[900]),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        cursorColor: Colors.green,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12.0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.green[900]),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Only allow digits
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildResultsTable() {
    return Center(
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
                "Tax on Brokerage Commission Income",
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
                _buildTableRow("Annual Brokerage/Commission Income",
                    _formatNumber(_annualFunds) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Annual Income Tax",
                    _formatNumber(_annualFundsTax) + " PKR",
                    isLast: true),
              ],
            ),
          ),
        ],
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
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  String _getFilerStatusDescription(String value) {
    switch (value) {
      case "filerYes":
        return "Filer - Yes";
      case "filerNo":
        return "Filer - No";
      default:
        return "Unknown";
    }
  }

  String _getPersonTypeDescription(String value) {
    switch (value) {
      case "valueOne":
        return "Advertising Agents";
      case "valueTwo":
        return "Life Insurance Agents (Commission < Rs. 0.5 million)";
      case "valueThree":
        return "Other Persons";
      default:
        return "Unknown";
    }
  }

  // Updated to include border radius
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

  void _showFilerStatusModal(BuildContext context) {
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
                title: Text('Filer - Yes'),
                onTap: () {
                  setState(() {
                    _selectedFilerStatus = "filerYes";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Filer - No'),
                onTap: () {
                  setState(() {
                    _selectedFilerStatus = "filerNo";
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

  void _showPersonTypeModal(BuildContext context) {
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
                title: Text('Advertising Agents'),
                onTap: () {
                  setState(() {
                    _selectedPersonType = "valueOne";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Life Insurance Agents (Commission < Rs. 0.5 million)'),
                onTap: () {
                  setState(() {
                    _selectedPersonType = "valueTwo";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Other Persons'),
                onTap: () {
                  setState(() {
                    _selectedPersonType = "valueThree";
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

  void _calculateTax() {
    double brokerIncome = double.tryParse(_brokerIncomeController.text) ?? 0.0;

    if (_selectedYear == "2023-2024") {
      if (_selectedFilerStatus == "filerYes") {
        if (_selectedPersonType == "valueOne") {
          _annualFundsTax = brokerIncome * 0.10;
        } else if (_selectedPersonType == "valueTwo") {
          _annualFundsTax = brokerIncome * 0.08;
        } else {
          _annualFundsTax = brokerIncome * 0.12;
        }
      } else {
        if (_selectedPersonType == "valueOne") {
          _annualFundsTax = brokerIncome * 0.20;
        } else if (_selectedPersonType == "valueTwo") {
          _annualFundsTax = brokerIncome * 0.16;
        } else {
          _annualFundsTax = brokerIncome * 0.24;
        }
      }
    } else if (_selectedYear == "2022-2023") {
      if (_selectedFilerStatus == "filerYes") {
        if (_selectedPersonType == "valueOne") {
          _annualFundsTax = brokerIncome * 0.10;
        } else if (_selectedPersonType == "valueTwo") {
          _annualFundsTax = brokerIncome * 0.08;
        } else {
          _annualFundsTax = brokerIncome * 0.12;
        }
      } else {
        if (_selectedPersonType == "valueOne") {
          _annualFundsTax = brokerIncome * 0.20;
        } else if (_selectedPersonType == "valueTwo") {
          _annualFundsTax = brokerIncome * 0.16;
        } else {
          _annualFundsTax = brokerIncome * 0.24;
        }
      }
    }

    _annualFunds = brokerIncome;

    setState(() {});
  }
}
