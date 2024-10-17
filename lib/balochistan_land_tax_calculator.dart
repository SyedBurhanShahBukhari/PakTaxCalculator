import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for FilteringTextInputFormatter
import 'package:intl/intl.dart'; // Import this for NumberFormat



class BalochistanLandTaxCalculator extends StatefulWidget {
  @override
  _BalochistanLandTaxCalculatorState createState() => _BalochistanLandTaxCalculatorState();
}

class _BalochistanLandTaxCalculatorState extends State<BalochistanLandTaxCalculator> {
  final numberFormat = NumberFormat('#,##0.00');
  final TextEditingController _agriIncomeController = TextEditingController();
  final TextEditingController _matrdIncomeController = TextEditingController();
  String _selectedYear = "2023-2024";
  String _landPeriod = "argiLand";
  String _selectStatus = "yes";
  double _annualArc = 0.0;
  double _annualArcTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Balochistan Agricultural Land Tax Calculator',
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
                    'Balochistan Tax on Agricultural Land Calculator $_selectedYear',
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
                    'This is latest Balochistan Agricultural land calculator as per $_selectedYear budget presented by government of Pakistan.',
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
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => _showLandPeriodSelectionModal(context),
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
                        _landPeriod == "argiLand"
                            ? "Agricultural Land in Acres"
                            : "Matured Orchard in Acres",
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                cursorColor: Colors.green,
                controller: _landPeriod == "argiLand"
                    ? _agriIncomeController
                    : _matrdIncomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: _landPeriod == "argiLand"
                      ? "Enter Agri Land in Acres"
                      : "Enter Matured Orchard in Acres",
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Restrict to digits
                ],
                onChanged: (value) {
                  setState(() {
                    _calculateTax();
                  });
                },
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
                        _selectStatus == "yes" ? "Yes" : "No",
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
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
                          _landPeriod == "argiLand"
                              ? "Balochistan Tax On Agri. Land"
                              : "Balochistan Tax On Matured Orchard",
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
                            _landPeriod == "argiLand" ? "Agri. Land In Acres" : "Matured. Land In Acres",
                            _annualArc,  // Pass the numeric value
                            unit: "ARC",  // Pass the unit separately
                          ),
                          Divider(height: 0.5, color: Colors.green),
                          _buildTableRow(
                            _landPeriod == "argiLand" ? "Tax on Agri. Income" : "Tax on Matured. Income",
                            _annualArcTax,  // Pass the numeric value
                            unit: "PKR",  // Pass the unit separately
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

  Widget _buildTableRow(String title, double value, {bool isLast = false, String unit = ""}) {
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
          Text(
            "${numberFormat.format(value)} $unit",  // Format number and append unit
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  void _calculateTax() {
    double landSize = double.tryParse(
        _landPeriod == "argiLand" ? _agriIncomeController.text : _matrdIncomeController.text) ??
        0.0;
    double taxAmount = 0.0;

    if (_selectStatus == "yes") {
      taxAmount = _statusYes(landSize);
    } else {
      taxAmount = _statusNo(landSize);
    }

    final numberFormat = NumberFormat('#,##0.00'); // Define format

    setState(() {
      _annualArc = landSize;
      _annualArcTax = taxAmount;
    });
  }



  double _statusYes(double landSize) {
    return 50 * landSize;
  }

  double _statusNo(double landSize) {
    return 0;
  }

  double _statusOrcdYes(double landSize) {
    return 200 * landSize;
  }

  double _statusOrcdNo(double landSize) {
    return 0;
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

  // Modal for Land Period Selection
  void _showLandPeriodSelectionModal(BuildContext context) {
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
                title: Text('Agricultural Land in Acres'),
                onTap: () {
                  setState(() {
                    _landPeriod = "argiLand";
                    _agriIncomeController.clear();
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Matured Orchard in Acres'),
                onTap: () {
                  setState(() {
                    _landPeriod = "matrdOrchad";
                    _matrdIncomeController.clear();
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

  // Modal for Status Selection
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
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Yes'),
                onTap: () {
                  setState(() {
                    _selectStatus = "yes";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('No'),
                onTap: () {
                  setState(() {
                    _selectStatus = "no";
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
