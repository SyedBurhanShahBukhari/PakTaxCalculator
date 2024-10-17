import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Added for input validation
import 'package:intl/intl.dart';  // Added for number formatting

class CompaniesTaxCalculator extends StatefulWidget {
  @override
  _TaxCalculatorState createState() => _TaxCalculatorState();
}

class _TaxCalculatorState extends State<CompaniesTaxCalculator> {
  final TextEditingController _businessController = TextEditingController();
  final TextEditingController _annualBusinessController = TextEditingController();
  final TextEditingController _smallBusinessController = TextEditingController();

  String _selectedPeriod = 'All Other Companies';
  int _annualIncome = 0;
  int _annualTax = 0;

  @override
  void dispose() {
    _businessController.dispose();
    _annualBusinessController.dispose();
    _smallBusinessController.dispose();
    super.dispose();
  }

  void _calculateTax() {
    int businessAmount = int.tryParse(_businessController.text) ?? 0;
    int taxAmount = _calculateTaxComp(businessAmount);

    setState(() {
      _annualIncome = businessAmount;
      _annualTax = taxAmount;
    });
  }

  void _calculateTaxBank() {
    int annualBusinessAmount = int.tryParse(_annualBusinessController.text) ?? 0;
    int taxAmount = _calculateTaxBanking(annualBusinessAmount);

    setState(() {
      _annualIncome = annualBusinessAmount;
      _annualTax = taxAmount;
    });
  }

  void _calculateTaxSmall() {
    int smallBusinessAmount = int.tryParse(_smallBusinessController.text) ?? 0;
    int taxAmount = _calculateTaxSmallComp(smallBusinessAmount);

    setState(() {
      _annualIncome = smallBusinessAmount;
      _annualTax = taxAmount;
    });
  }

  int _calculateTaxComp(int amount) {
    return (amount * 0.29).round();
  }

  int _calculateTaxBanking(int amount) {
    return (amount * 0.39).round();
  }

  int _calculateTaxSmallComp(int amount) {
    return (amount * 0.2).round();
  }

  void _showPeriodSelectionModal(BuildContext context) {
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
                title: Text('All Other Companies'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "All Other Companies";
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Banking Company'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "Banking Company";
                    _calculateTaxBank();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Small Company'),
                onTap: () {
                  setState(() {
                    _selectedPeriod = "Small Company";
                    _calculateTaxSmall();
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

  String _formatNumber(int number) {  // Added for number formatting
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  Widget _buildResultTable() {
    return Column(
      children: [
        if (_selectedPeriod == "All Other Companies")
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
                      'Tax on All Other Companies',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _buildTableRow('Annual Income', _annualIncome),
                _buildTableRow('Tax on All Other Companies', _annualTax,
                    isLast: true),
              ],
            ),
          ),
        if (_selectedPeriod == "Banking Company")
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
                      'Tax on Banking Company',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _buildTableRow('Annual Income', _annualIncome),
                _buildTableRow('Tax on Banking Company', _annualTax,
                    isLast: true),
              ],
            ),
          ),
        if (_selectedPeriod == "Small Company")
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
                      'Tax on Small Company',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _buildTableRow('Annual Income', _annualIncome),
                _buildTableRow('Tax on Small Company', _annualTax,
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
          'Tax on Annual Income of Companies',
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
                    'Tax on Annual Income of Companies for Tax Year 2024-2025',
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
                    'This is the latest Tax on Annual Income of Companies tax calculator as per the 2024-2025 budget presented by the government of Pakistan.',
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
                onTap: () => _showPeriodSelectionModal(context),
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
                        _selectedPeriod,
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_selectedPeriod == "All Other Companies")
                TextField(
                  controller: _businessController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Enter Annual Income of All Other Companies',
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

              if (_selectedPeriod == "Banking Company")
                TextField(
                  controller: _annualBusinessController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Enter Annual Income of Banking Company',
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
                  onChanged: (text) => _calculateTaxBank(),
                ),
              if (_selectedPeriod == "Small Company")
                TextField(
                  controller: _smallBusinessController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Added input validation
                  decoration: InputDecoration(
                    labelText: 'Enter Annual Income of Small Company',
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
                  onChanged: (text) => _calculateTaxSmall(),
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
