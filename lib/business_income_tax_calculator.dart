import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class BusinessTaxCalculator extends StatefulWidget {
  @override
  _BusinessTaxCalculatorState createState() => _BusinessTaxCalculatorState();
}

class _BusinessTaxCalculatorState extends State<BusinessTaxCalculator> {
  final TextEditingController _businessAmountController = TextEditingController();
  String _selectedYear = '2024-2025';
  String _taxType = 'aop';
  int _accountingProfit = 0;
  int _taxOnProfit = 0;
  int _profitAfterTax = 0;

  @override
  void dispose() {
    _businessAmountController.dispose();
    super.dispose();
  }

  void _calculateTax() {
    int businessAmount = int.tryParse(_businessAmountController.text) ?? 0;
    int taxAmount = 0;

    if (_taxType == 'aop') {
      taxAmount = _calculateTaxForAOP(businessAmount);
    } else {
      taxAmount = _calculateTaxForIndividuals(businessAmount);
    }

    setState(() {
      _accountingProfit = businessAmount;
      _taxOnProfit = taxAmount;
      _profitAfterTax = businessAmount - taxAmount;
    });
  }

  int _calculateTaxForAOP(int amount) {
    if (amount <= 600000) return 0;
    if (amount <= 1200000) return ((amount - 600000) * 0.15).round();
    if (amount <= 1600000) return (90000 + (amount - 1200000) * 0.20).round();
    if (amount <= 3200000) return (170000 + (amount - 1600000) * 0.30).round();
    if (amount <= 5600000) return (650000 + (amount - 3200000) * 0.40).round();
    return (1610000 + (amount - 5600000) * 0.45).round();
  }

  int _calculateTaxForIndividuals(int amount) {
    if (amount <= 600000) return 0;
    if (amount <= 1200000) return ((amount - 600000) * 0.15).round();
    if (amount <= 1600000) return (90000 + (amount - 1200000) * 0.20).round();
    if (amount <= 3200000) return (170000 + (amount - 1600000) * 0.30).round();
    if (amount <= 5600000) return (650000 + (amount - 3200000) * 0.40).round();
    return (1610000 + (amount - 5600000) * 0.45).round();
  }

  // Add the _formatNumber method here
  String _formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
        automaticallyImplyLeading: false,

        leading: Container(
          margin: EdgeInsets.only(left: 15, top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.green),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Business Tax Calculator',
              style: TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Business Tax Calculator $_selectedYear',
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
                    'This is the latest business tax calculator as per $_selectedYear budget presented by the government of Pakistan.',
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
              _buildTaxTypeSelector(),
              SizedBox(height: 20),
              TextField(
                controller: _businessAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Restrict input to digits only
                ],
                decoration: InputDecoration(
                  labelText: 'Enter Business Amount',
                  labelStyle: TextStyle(
                    color: Colors.green[900], // Active label color
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Active border color
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                cursorColor: Colors.green, // Cursor (caret) color
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
              SizedBox(height: 30),
              _buildResultTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaxTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<String>(
          title: Text('AOP - Prohibited Incorporation Due to Law or Rules'),
          value: 'aop',
          groupValue: _taxType,
          activeColor: Colors.green,
          onChanged: (value) {
            setState(() {
              _taxType = value!;
              _calculateTax();
            });
          },
        ),
        RadioListTile<String>(
          title: Text('Individuals & other AOPs'),
          value: 'individuals',
          groupValue: _taxType,
          activeColor: Colors.green,
          onChanged: (value) {
            setState(() {
              _taxType = value!;
              _calculateTax();
            });
          },
        ),
      ],
    );
  }

  void _showYearSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          // bottomRight: Radius.circular(20.0), // Apply the border radius here as well
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0), // Apply the border radius here as well
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('2024-2025'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2024-2025";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
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
              ListTile(
                title: Text('2021-2022'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2021-2022";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('2020-2021'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2020-2021";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('2019-2020'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2019-2020";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('2018-2019'),
                onTap: () {
                  setState(() {
                    _selectedYear = "2018-2019";
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

  Widget _buildResultTable() {
    return Card(
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
                'Business Tax Results',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildTableRow('Accounting Profit', _accountingProfit),
          _buildTableRow('Tax On Profit', _taxOnProfit),
          _buildTableRow('Profit After Tax', _profitAfterTax, isLast: true),
        ],
      ),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
          Text(
            '${_formatNumber(amount)} PKR', // Display the formatted number with commas
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }
}
