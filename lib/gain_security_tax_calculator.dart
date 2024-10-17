import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For input validation
import 'package:intl/intl.dart';  // For number formatting

class GainSecurityTaxCalculator extends StatefulWidget {
  @override
  _GainTaxCalculatorState createState() => _GainTaxCalculatorState();
}

class _GainTaxCalculatorState extends State<GainSecurityTaxCalculator> {
  final TextEditingController _aftController = TextEditingController();
  final TextEditingController _befController = TextEditingController();
  final TextEditingController _compController = TextEditingController();
  final TextEditingController _bcController = TextEditingController();
  final TextEditingController _scController = TextEditingController();
  final TextEditingController _fcController = TextEditingController();
  final TextEditingController _befJulyController = TextEditingController();

  String _selectedPeriod = "purhAft";
  String _selectedStatus = "valueOne";
  double _annualIncome = 0.0;
  double _annualIncomeTax = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capital Gain Securities Tax Calculator',
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
                    'Capital Gain Securities Tax Calculator Pakistan 2024-2025',
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
                    'This is latest Capital Gain on Securities Tax calculator as per 2024-2025 budget presented by government of Pakistan.',
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
                        _getPeriodText(),
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.0),

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
                        _getStatusText(),
                        style: TextStyle(fontSize: 18, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),
              _buildInputField(
                controller: _aftController,
                labelText: "Enter Securities purchased After 01 July 2022 - Individual / AOP",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "purhAft",
              ),
              _buildInputField(
                controller: _befController,
                labelText: "Enter Securities purchased Before 01 July 2022 - Individual / AOP",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "purhBef",
              ),
              _buildInputField(
                controller: _compController,
                labelText: "Enter Capital Gain on Securities purchased - Companies",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "purhComp",
              ),
              _buildInputField(
                controller: _bcController,
                labelText: "Enter Capital Gain on Securities purchased - Banking Company",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "purhBc",
              ),
              _buildInputField(
                controller: _scController,
                labelText: "Enter Capital Gain on Securities purchased - Small Company",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "purhSc",
              ),
              _buildInputField(
                controller: _fcController,
                labelText: "Enter Future Commodity Contract by Member of Pakistan Mercantile Exchange",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "furtCom",
              ),
              _buildInputField(
                controller: _befJulyController,
                labelText: "Enter Before 01 July 2013 - Individual / AOP",
                onChanged: (value) => _calculateTax(),
                visible: _selectedPeriod == "befJuly",
              ),
              SizedBox(height: 30),
              _buildResultsTable(),
            ],
          ),
        ),
      ),
    );
  }

  String _getPeriodText() {
    switch (_selectedPeriod) {
      case "purhAft":
        return "On or After 01 July 2022 - Individual / AOP";
      case "purhBef":
        return "Before 01 July 2022 - Individual / AOP";
      case "purhComp":
        return "Companies";
      case "purhBc":
        return "Banking Company";
      case "purhSc":
        return "Small Company";
      case "furtCom":
        return "Future Commodity Contract";
      case "befJuly":
        return "Before 01 July 2013 - Individual / AOP";
      default:
        return "";
    }
  }

  String _getStatusText() {
    switch (_selectedStatus) {
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
        return "";
    }
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
              _buildModalOption("purhAft", "On or After 01 July 2022 - Individual / AOP"),
              _buildModalOption("purhBef", "Before 01 July 2022 - Individual / AOP"),
              _buildModalOption("purhComp", "Companies"),
              _buildModalOption("purhBc", "Banking Company"),
              _buildModalOption("purhSc", "Small Company"),
              _buildModalOption("furtCom", "Future Commodity Contract"),
              _buildModalOption("befJuly", "Before 01 July 2013 - Individual / AOP"),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildModalOption("valueOne", "Does not exceed one year"),
              _buildModalOption("valueTwo", "Exceeds one year but does not exceed two years"),
              _buildModalOption("valueThree", "Exceeds two years but does not exceed three years"),
              _buildModalOption("valueFour", "Exceeds three years but does not exceed four years"),
              _buildModalOption("valueFive", "Exceeds four years but does not exceed five years"),
              _buildModalOption("valueSix", "Exceeds five years but does not exceed six years"),
              _buildModalOption("valueSeven", "Exceeds six years"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalOption(String value, String text) {
    return ListTile(
      title: Text(text),
      onTap: () {
        setState(() {
          if (_selectedPeriod == value || _selectedStatus == value) return;
          if (_selectedPeriod == "purhAft" ||
              _selectedPeriod == "purhBef" ||
              _selectedPeriod == "purhComp" ||
              _selectedPeriod == "purhBc" ||
              _selectedPeriod == "purhSc" ||
              _selectedPeriod == "furtCom" ||
              _selectedPeriod == "befJuly") {
            _selectedPeriod = value;
          } else {
            _selectedStatus = value;
          }
          _calculateTax();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required ValueChanged<String> onChanged,
    required bool visible,
  }) {
    return Visibility(
      visible: visible,
      child: Padding(
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
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],  // Restrict input to digits
          keyboardType: TextInputType.number,
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
                _buildTableRow("Capital Gain", _formatNumber(_annualIncome) + " PKR"),
                Divider(height: 0.5, color: Colors.green),
                _buildTableRow("Capital Gain Annual Income Tax", _formatNumber(_annualIncomeTax) + " PKR", isLast: true),
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
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(number);
  }

  void _calculateTax() {
    double incomeAmount = 0.0;
    if (_selectedPeriod == "purhAft") {
      incomeAmount = double.tryParse(_aftController.text) ?? 0.0;
    } else if (_selectedPeriod == "purhBef") {
      incomeAmount = double.tryParse(_befController.text) ?? 0.0;
    } else if (_selectedPeriod == "purhComp") {
      incomeAmount = double.tryParse(_compController.text) ?? 0.0;
    } else if (_selectedPeriod == "purhBc") {
      incomeAmount = double.tryParse(_bcController.text) ?? 0.0;
    } else if (_selectedPeriod == "purhSc") {
      incomeAmount = double.tryParse(_scController.text) ?? 0.0;
    } else if (_selectedPeriod == "furtCom") {
      incomeAmount = double.tryParse(_fcController.text) ?? 0.0;
    } else if (_selectedPeriod == "befJuly") {
      incomeAmount = double.tryParse(_befJulyController.text) ?? 0.0;
    }

    double taxAmount = 0.0;

    if (_selectedStatus == "valueOne") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueTwo") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueThree") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueFour") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueFive") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueSix") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    } else if (_selectedStatus == "valueSeven") {
      taxAmount = _calculateTaxAmount(incomeAmount, 0.125);
    }

    setState(() {
      _annualIncome = incomeAmount;
      _annualIncomeTax = taxAmount;
    });
  }

  double _calculateTaxAmount(double income, double rate) {
    return income > 0 ? income * rate : 0.0;
  }
}
