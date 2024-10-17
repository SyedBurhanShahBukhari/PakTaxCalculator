import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for input validation
import 'package:intl/intl.dart'; // Added for number formatting

class CapitalGainFundsTaxCalculator extends StatefulWidget {
  @override
  _CapitalGainTaxCalculatorState createState() => _CapitalGainTaxCalculatorState();
}

class _CapitalGainTaxCalculatorState extends State<CapitalGainFundsTaxCalculator> {
  final TextEditingController _fundsController = TextEditingController();
  String _selectedStatus = "valueOne";
  double _annualIncome = 0.0;
  double _annualTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capital Gain Mutul Fund Tax Calculator',
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
                    'Capital Gain on Mutual Funds Tax Calculator Pakistan 2024-2025',
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
                    'This is latest Capital Gain on Mutual Funds Tax calculator as per 2024-2025 budget presented by government of Pakistan.',
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
                onTap: () => _showStatusSelectionModal(context),
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
                        _getStatusDescription(_selectedStatus),
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              _buildInputField(
                controller: _fundsController,
                labelText: "Enter Capital Gain on Funds",
                onChanged: (value) => _calculateTax(),
              ),
              SizedBox(height: 30),
              _buildResultsTable(),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusDescription(String value) {
    switch (value) {
      case "valueOne":
        return "Individual / AOP - Stock Funds";
      case "valueTwo":
        return "Individual / AOP - Other Funds";
      case "valueThree":
        return "Companies - Stock Funds";
      case "valueFour":
        return "Company - Other Funds";
      case "valueFive":
        return "Dividend receipts of the fund are less than capital gains";
      case "valueSix":
        return "Holding period of the security is more than six years";
      default:
        return "Select Status";
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        cursorColor: Colors.green,  // Set cursor color to green
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
          labelStyle: TextStyle(color: Colors.green[900]),  // Set label color to green
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Restrict input to digits only
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
                "Tax Results",
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
                _buildTableRow("Annual Income Funds", _formatNumber(_annualIncome) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Annual Tax on Income", _formatNumber(_annualTax) + " PKR", isLast: true),
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

  String _formatNumber(double number) {  // Added for number formatting
    final formatter = NumberFormat('#,###.00');
    return formatter.format(number);
  }

  void _showStatusSelectionModal(BuildContext context) {
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
                title: Text('Individual / AOP - Stock Funds'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueOne";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Individual / AOP - Other Funds'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueTwo";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Companies - Stock Funds'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueThree";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Company - Other Funds'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueFour";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Dividend receipts of the fund are less than capital gains'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueFive";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Holding period of the security is more than six years'),
                onTap: () {
                  setState(() {
                    _selectedStatus = "valueSix";
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
    double incomeAmount = double.tryParse(_fundsController.text) ?? 0.0;
    double taxAmount = 0.0;

    if (_selectedStatus == "valueOne") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.1);
    } else if (_selectedStatus == "valueTwo") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.1);
    } else if (_selectedStatus == "valueThree") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.1);
    } else if (_selectedStatus == "valueFour") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.25);
    } else if (_selectedStatus == "valueFive") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueSix") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.0);
    }

    setState(() {
      _annualIncome = incomeAmount;
      _annualTax = taxAmount;
    });
  }

  double _calculateTaxAmount(double income, double rate) {
    return income > 0 ? income * rate : 0.0;
  }
}
