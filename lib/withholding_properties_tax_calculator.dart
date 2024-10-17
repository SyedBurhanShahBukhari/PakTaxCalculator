import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input validation
import 'package:intl/intl.dart'; // For number formatting

class WithholdingPropertiesTaxCalculator extends StatefulWidget {
  @override
  _WithholdingTaxCalculatorState createState() => _WithholdingTaxCalculatorState();
}

class _WithholdingTaxCalculatorState extends State<WithholdingPropertiesTaxCalculator> {
  final TextEditingController _rentIncomeController = TextEditingController();
  final TextEditingController _advanceAmountController = TextEditingController();

  String _selectedYear = "2023-2024";
  String _selectedFrequency = "monthly";
  String _selectedAdvanceStatus = "yes";
  String _selectedType = "individual";
  String _selectedAdvanceGiven = "adjustable";

  double _annualRent = 0.0;
  double _advanceAdded = 0.0;
  double _taxableAmount = 0.0;
  double _annualIncomeTax = 0.0;
  double _monthlyIncomeTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withholding on Income from Properties',
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
                    'Withholding on Income from Properties Tax Calculator Pakistan $_selectedYear',
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
                    'This is latest builder tax calculator as per $_selectedYear budget presented by government of Pakistan.',
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
              _buildRadioGroup(),
              SizedBox(height: 20),
              _buildInputField(
                controller: _rentIncomeController,
                labelText: "Enter Rent of Immoveable Property",
                onChanged: (value) => _calculateTax(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showYearSelectionModal(context),
                child: _buildDropdownContainer(_selectedYear),
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _advanceAmountController,
                labelText: "Enter Advance Amount",
                onChanged: (value) => _calculateTax(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showFrequencySelectionModal(context),
                child: _buildDropdownContainer(_getFrequencyDescription(_selectedFrequency)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showAdvanceStatusSelectionModal(context),
                child: _buildDropdownContainer(_selectedAdvanceStatus == "yes" ? "Advance Given - Yes" : "Advance Given - No"),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showAdvanceGivenSelectionModal(context),
                child: _buildDropdownContainer(_selectedAdvanceGiven == "adjustable" ? "Adjustable against Rent" : "Refundable to Tenant"),
              ),
              SizedBox(height: 30),
              _buildResultsTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Select Type:",
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.green,
              ),
              child: Radio<String>(
                value: "individual",
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _calculateTax();
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            Text("Individual / AOP"),
            SizedBox(width: 20),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.green,
              ),
              child: Radio<String>(
                value: "company",
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _calculateTax();
                  });
                },
                activeColor: Colors.green,
              ),
            ),
            Text("Company"),
          ],
        ),
      ],
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
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Restrict input to digits
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12.0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.green[900]), // Set label text color to green
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.number,
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
                "Withholding Tax Income from Properties",
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
                    "Annual Rent - ${_selectedType == "individual" ? "Indiv/AOP as Owner" : "Company as Owner"}",
                    _formatNumber(_annualRent) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Advance given Income", _formatNumber(_advanceAdded) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Taxable Amount", _formatNumber(_taxableAmount) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Annual Income Tax", _formatNumber(_annualIncomeTax) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Income Tax On ${_getFrequencyDescription(_selectedFrequency)} Payment", _formatNumber(_monthlyIncomeTax) + " PKR", isLast: true),
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

  String _getFrequencyDescription(String value) {
    switch (value) {
      case "monthly":
        return "Monthly";
      case "quarterly":
        return "Quarterly";
      case "biannually":
        return "Biannually";
      case "annually":
        return "Annually";
      default:
        return "Unknown";
    }
  }

  void _showYearSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),  // Adjust this value for the degree of rounding
          topRight: Radius.circular(30.0), // Adjust this value for the degree of rounding
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),  // Ensure modal content has same radius
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
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

  void _showFrequencySelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),  // Adjust this value for the degree of rounding
          topRight: Radius.circular(30.0), // Adjust this value for the degree of rounding
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Monthly'),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "monthly";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Quarterly'),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "quarterly";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Biannually'),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "biannually";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Annually'),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "annually";
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

  void _showAdvanceStatusSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),  // Adjust this value for the degree of rounding
          topRight: Radius.circular(30.0), // Adjust this value for the degree of rounding
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Advance Given - Yes'),
                onTap: () {
                  setState(() {
                    _selectedAdvanceStatus = "yes";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Advance Given - No'),
                onTap: () {
                  setState(() {
                    _selectedAdvanceStatus = "no";
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

  void _showAdvanceGivenSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),  // Adjust this value for the degree of rounding
          topRight: Radius.circular(30.0), // Adjust this value for the degree of rounding
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Adjustable against Rent'),
                onTap: () {
                  setState(() {
                    _selectedAdvanceGiven = "adjustable";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Refundable to Tenant'),
                onTap: () {
                  setState(() {
                    _selectedAdvanceGiven = "refundable";
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


  Widget _buildModalContent(BuildContext context, List<String> options, Function(String) onTap) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () => onTap(option),
          );
        }).toList(),
      ),
    );
  }

  void _calculateTax() {
    double rentIncome = double.tryParse(_rentIncomeController.text) ?? 0.0;
    double advanceAmount = double.tryParse(_advanceAmountController.text) ?? 0.0;

    switch (_selectedFrequency) {
      case 'monthly':
        _annualRent = rentIncome * 12;
        break;
      case 'quarterly':
        _annualRent = rentIncome * 4;
        break;
      case 'biannually':
        _annualRent = rentIncome * 2;
        break;
      case 'annually':
        _annualRent = rentIncome;
        break;
    }

    if (_selectedAdvanceGiven == 'refundable') {
      _advanceAdded = advanceAmount * 0.1;
    } else {
      _advanceAdded = 0;
    }

    _taxableAmount = _annualRent + _advanceAdded;

    if (_selectedType == "individual") {
      if (_taxableAmount <= 300000) {
        _annualIncomeTax = 0;
      } else if (_taxableAmount <= 600000) {
        _annualIncomeTax = (_taxableAmount - 300001) * 0.05;
      } else if (_taxableAmount <= 2000000) {
        _annualIncomeTax = (_taxableAmount - 600001) * 0.1 + 15000;
      } else {
        _annualIncomeTax = (_taxableAmount - 2000001) * 0.25 + 155000;
      }
    } else {
      _annualIncomeTax = _taxableAmount * 0.15;
    }

    switch (_selectedFrequency) {
      case 'monthly':
        _monthlyIncomeTax = _annualIncomeTax / 12;
        break;
      case 'quarterly':
        _monthlyIncomeTax = _annualIncomeTax / 4;
        break;
      case 'biannually':
        _monthlyIncomeTax = _annualIncomeTax / 2;
        break;
      case 'annually':
        _monthlyIncomeTax = _annualIncomeTax;
        break;
    }

    setState(() {});
  }

  String _formatNumber(double value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }
}
