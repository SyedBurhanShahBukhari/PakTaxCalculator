import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For input validation
import 'package:intl/intl.dart';  // For number formatting

class BuilderTaxCalculator extends StatefulWidget {
  @override
  _BuilderIncomeTaxCalculatorState createState() => _BuilderIncomeTaxCalculatorState();
}

class _BuilderIncomeTaxCalculatorState extends State<BuilderTaxCalculator> {
  final TextEditingController _commercialController = TextEditingController();
  final TextEditingController _residentialController = TextEditingController();

  String _selectedYear = '2023-2024';
  String _selectedPropertyType = 'Commercial Property';
  String _selectedCity = 'Karachi';
  int _area = 0;
  int _annualTax = 0;

  @override
  void dispose() {
    _commercialController.dispose();
    _residentialController.dispose();
    super.dispose();
  }

  void _calculateTax() {
    int area = int.tryParse(
        _selectedPropertyType == 'Commercial Property'
            ? _commercialController.text
            : _residentialController.text) ?? 0;

    int taxAmount = _calculatePropertyTax(area);
    setState(() {
      _area = area;
      _annualTax = taxAmount;
    });
  }

  int _calculatePropertyTax(int area) {
    int taxRate;
    if (_selectedPropertyType == 'Commercial Property') {
      taxRate = 210; // Fixed tax rate for Commercial
    } else {
      switch (_selectedCity) {
        case 'Karachi':
          taxRate = 20;
          break;
        case 'Lahore':
          taxRate = 40;
          break;
        default:
          taxRate = 70;
      }
    }
    return area * taxRate;
  }

  void _showPropertyTypeSelectionModal(BuildContext context) {
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
                title: Text('Commercial Property'),
                onTap: () {
                  setState(() {
                    _selectedPropertyType = "Commercial Property";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Residential Property'),
                onTap: () {
                  setState(() {
                    _selectedPropertyType = "Residential Property";
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

  void _showCitySelectionModal(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Karachi'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Karachi";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Lahore'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Lahore";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Islamabad'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Islamabad";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Faisalabad'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Faisalabad";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Rawalpindi'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Rawalpindi";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Gujranwala'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Gujranwala";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Sahiwal'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Sahiwal";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Peshawar'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Peshawar";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Mardan'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Mardan";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Abbottabad'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Abbottabad";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Urban Areas Not Specified Above'),
                  onTap: () {
                    setState(() {
                      _selectedCity = "Urban";
                      _calculateTax();
                    });
                    Navigator.pop(context);
                  },
                ),

                // Add more cities as needed...
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNumber(int number) {  // Added for number formatting
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
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
                    'Tax on $_selectedPropertyType',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _buildTableRow('Property Area in Square Feet', _area),
              _buildTableRow('Annual Income Tax', _annualTax, isLast: true),
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
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
          Text(
            '${_formatNumber(amount)} PKR',  // Updated to format number with commas
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Builder Tax Calculator',
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
                    'Builder Tax Calculator for 2024-2025',
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
                    'This is the latest builder tax calculator as per the 2024-2025 budget presented by the government of Pakistan.',
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
                        _selectedPropertyType,
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_selectedPropertyType == "Commercial Property")
                TextField(
                  controller: _commercialController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Enter Area in Square Feet - Commercial Property',
                    labelStyle: TextStyle(
                      color: Colors.green[900],  // Set the label color to green
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
                  cursorColor: Colors.green,  // Set the caret color to green
                  onChanged: (text) => _calculateTax(),
                ),
              if (_selectedPropertyType == "Residential Property")
                TextField(
                  controller: _residentialController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Enter Area in Square Feet - Residential Property',
                    labelStyle: TextStyle(
                      color: Colors.green[900],  // Set the label color to green
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
                  cursorColor: Colors.green,  // Set the caret color to green
                  onChanged: (text) => _calculateTax(),
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
                onTap: () => _showCitySelectionModal(context),
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
                        _selectedCity,
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
}
