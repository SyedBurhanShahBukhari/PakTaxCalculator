import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For input validation
import 'package:intl/intl.dart';  // For number formatting

class DeveloperTaxCalculator extends StatefulWidget {
  @override
  _DeveloperTaxCalculatorState createState() => _DeveloperTaxCalculatorState();
}

class _DeveloperTaxCalculatorState extends State<DeveloperTaxCalculator> {
  final TextEditingController _commIncomeController = TextEditingController();
  final TextEditingController _residIncomeController = TextEditingController();

  String _selectedYear = '2023-2024';
  String _selectedLandPeriod = 'Commercial Property';
  String _selectedStatus = 'Karachi';
  double _annualIncome = 0.0;
  double _annualTax = 0.0;

  @override
  void dispose() {
    _commIncomeController.dispose();
    _residIncomeController.dispose();
    super.dispose();
  }

  void _calculateTax() {
    double landSize = double.tryParse(_commIncomeController.text) ?? 0.0;
    double taxAmount = _calculateCommercialTax(landSize);

    setState(() {
      _annualIncome = landSize;
      _annualTax = taxAmount;
    });
  }

  void _calculateTaxResidential() {
    double landSize = double.tryParse(_residIncomeController.text) ?? 0.0;
    double taxAmount = _calculateResidentialTax(landSize);

    setState(() {
      _annualIncome = landSize;
      _annualTax = taxAmount;
    });
  }

  double _calculateCommercialTax(double landSize) {
    return landSize * 210; // Example calculation, modify as needed
  }

  double _calculateResidentialTax(double landSize) {
    if (landSize <= 120) {
      return landSize * 20;
    } else if (landSize <= 200) {
      return landSize * 40;
    } else {
      return landSize * 70;
    }
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
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('2022-2023'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2022-2023";
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

  void _showLandSelectionModal(BuildContext context) {
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
                    _selectedLandPeriod = "Commercial Property";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Residential Property'),
                onTap: () {
                  setState(() {
                    _selectedLandPeriod = "Residential Property";
                    _calculateTaxResidential();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Karachi'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Karachi";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Lahore'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Lahore";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Islamabad'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Islamabad";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Hyderabad'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Hyderabad";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Sukkur'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Sukkur";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Multan'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Multan";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Faisalabad'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Faisalabad";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Rawalpindi'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Rawalpindi";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Gujranwala'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Gujranwala";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Sahiwal'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Sahiwal";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Peshawar'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Peshawar";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Mardan'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Mardan";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Abbottabad'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Abbottabad";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Urban Areas Not Specified Above'),
                  onTap: () {
                    setState(() {
                      _selectedStatus = "Urban";
                      if (_selectedLandPeriod == "Commercial Property") {
                        _calculateTax();
                      } else {
                        _calculateTaxResidential();
                      }
                    });
                    Navigator.pop(context);
                  },
                ),

                // Add more status options as needed
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNumber(double number) {  // Added for number formatting
    final formatter = NumberFormat('#,###.##');
    return formatter.format(number);
  }

  Widget _buildResultTable() {
    return Column(
      children: [
        if (_selectedLandPeriod == "Commercial Property")
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
                      'Tax on Commercial Property',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _buildTableRow('Commercial Property In Square Yard', _annualIncome),
                _buildTableRow('Annual Income Tax', _annualTax, isLast: true),
              ],
            ),
          ),
        if (_selectedLandPeriod == "Residential Property")
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
                      'Tax on Residential Property',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _buildTableRow('Residential Property In Square Yard', _annualIncome),
                _buildTableRow('Annual Income Tax', _annualTax, isLast: true),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTableRow(String title, double amount, {bool isLast = false}) {
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
          'Developer Tax Calculator',
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
                    'Developer Tax Calculator Pakistan $_selectedYear',
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
                    'This is the latest developer tax calculator as per the $_selectedYear budget presented by the government of Pakistan.',
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
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showLandSelectionModal(context),
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
                        _selectedLandPeriod,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        _selectedStatus,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_selectedLandPeriod == "Commercial Property")
                TextField(
                  controller: _commIncomeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Area in Square Yard - Commercial Property',
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
              if (_selectedLandPeriod == "Residential Property")
                TextField(
                  controller: _residIncomeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Area in Square Yard - Residential Property',
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
                  onChanged: (text) => _calculateTaxResidential(),
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
