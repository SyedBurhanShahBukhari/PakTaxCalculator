import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input validation
import 'package:intl/intl.dart'; // For number formatting

class CapitalGainPropertiesTaxCalculator extends StatefulWidget {
  @override
  _CapitalGainPropertiesTaxCalculatorState createState() =>
      _CapitalGainPropertiesTaxCalculatorState();
}

class _CapitalGainPropertiesTaxCalculatorState
    extends State<CapitalGainPropertiesTaxCalculator> {
  final TextEditingController _opPlotController = TextEditingController();
  final TextEditingController _conPropertyController = TextEditingController();
  final TextEditingController _flatsController = TextEditingController();

  String _selectedPropertyType = "opPlots";
  String _selectedPeriod = "valueOne";
  double _annualIncome = 0.0;
  double _annualTax = 0.0;

  // Format the number with commas
  String _formatNumber(double number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capital Gain Properties Tax Calculator',
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
                    'Capital Gain on Property Tax Calculator Pakistan 2024-2025',
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
                    'This is latest Capital Gain on Property Tax calculator as per 2024-2025 budget presented by government of Pakistan.',
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
                onTap: () => _showPropertyTypeSelectionModal(context),
                child: _buildDropdownContainer(
                  _getPropertyTypeDescription(_selectedPropertyType),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showPeriodSelectionModal(context),
                child: _buildDropdownContainer(
                  _getPeriodDescription(_selectedPeriod),
                ),
              ),
              SizedBox(height: 30),
              _buildInputField(
                controller: _opPlotController,
                labelText: "Enter Capital Gain on properties - Open Plots",
                visible: _selectedPropertyType == "opPlots",
                onChanged: (value) => _calculateTax(),
              ),
              _buildInputField(
                controller: _conPropertyController,
                labelText:
                "Enter Capital Gain on properties - Constructed Property",
                visible: _selectedPropertyType == "conProp",
                onChanged: (value) => _calculateTax(),
              ),
              _buildInputField(
                controller: _flatsController,
                labelText: "Enter Capital Gain on properties - Flats",
                visible: _selectedPropertyType == "flats",
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
    required bool visible,
    required ValueChanged<String> onChanged,
  }) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextFormField(
          cursorColor: Colors.green,
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow digits only
          ],
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
          onChanged: onChanged,
        ),
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
                _buildTableRow(
                  _getPropertyTypeTitle(_selectedPropertyType),
                  '${_formatNumber(_annualIncome)} PKR', // Format result with commas
                ),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Capital Gain Annual Income Tax",
                    '${_formatNumber(_annualTax)} PKR', isLast: true),
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

  // Helper Functions for Modals

  String _getPropertyTypeDescription(String value) {
    switch (value) {
      case "opPlots":
        return "Open Plots";
      case "conProp":
        return "Constructed Property";
      case "flats":
        return "Flats";
      default:
        return "Select Property Type";
    }
  }

  String _getPropertyTypeTitle(String value) {
    switch (value) {
      case "opPlots":
        return "Capital Gain On Open Plots";
      case "conProp":
        return "Capital Gain On Constructed Property";
      case "flats":
        return "Capital Gain On Flats";
      default:
        return "Capital Gain On Property";
    }
  }

  String _getPeriodDescription(String value) {
    switch (value) {
      case "valueOne":
        return "Does not exceed one year";
      case "valueTwo":
        return "Exceeds one year but does not exceed two years";
      case "valueThree":
        return "Exceeds two years but does not exceed three years";
      case "valueFour":
        return "Exceeds three years but does not exceed four years";
      case "valueFive":
        return "Exceeds four years but does not exceed five years";
      case "valueSix":
        return "Exceeds five years but does not exceed six years";
      case "valueSeven":
        return "Exceeds six years";
      default:
        return "Select Period";
    }
  }

  void _showPropertyTypeSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Added consistent border-radius
          topRight: Radius.circular(20.0), // Added consistent border-radius
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Added consistent border-radius
              topRight: Radius.circular(20.0), // Added consistent border-radius
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Open Plots'),
                onTap: () {
                  setState(() {
                    _selectedPropertyType = "opPlots";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Constructed Property'),
                onTap: () {
                  setState(() {
                    _selectedPropertyType = "conProp";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Flats'),
                onTap: () {
                  setState(() {
                    _selectedPropertyType = "flats";
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

  void _showPeriodSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Added consistent border-radius
          topRight: Radius.circular(20.0), // Added consistent border-radius
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Added consistent border-radius
              topRight: Radius.circular(20.0), // Added consistent border-radius
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Does not exceed one year'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueOne";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds one year but does not exceed two years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueTwo";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds two years but does not exceed three years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueThree";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds three years but does not exceed four years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueFour";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds four years but does not exceed five years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueFive";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds five years but does not exceed six years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueSix";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Exceeds six years'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "valueSeven";
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
    double incomeAmount = 0.0;

    if (_selectedPropertyType == "opPlots") {
      incomeAmount = double.tryParse(_opPlotController.text) ?? 0.0;
    } else if (_selectedPropertyType == "conProp") {
      incomeAmount = double.tryParse(_conPropertyController.text) ?? 0.0;
    } else if (_selectedPropertyType == "flats") {
      incomeAmount = double.tryParse(_flatsController.text) ?? 0.0;
    }

    double taxAmount = 0.0;

    if (_selectedPeriod == "valueOne") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.15);
    } else if (_selectedPeriod == "valueTwo") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedPeriod == "valueThree") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.1);
    } else if (_selectedPeriod == "valueFour") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.075);
    } else if (_selectedPeriod == "valueFive") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.05);
    } else if (_selectedPeriod == "valueSix") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.025);
    } else if (_selectedPeriod == "valueSeven") {
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
