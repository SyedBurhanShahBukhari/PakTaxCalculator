import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class SalaryTaxCalculator extends StatefulWidget {
  @override
  _SalaryTaxCalculatorState createState() => _SalaryTaxCalculatorState();
}

class _SalaryTaxCalculatorState extends State<SalaryTaxCalculator> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _salaryYearController = TextEditingController();
  String _selectedPeriod = 'monthly';
  String _selectedYear = '2024-2025';
  int _monthlySalary = 0;
  int _yearlySalary = 0;
  int _monthlyTax = 0;
  int _yearlyTax = 0;
  int _salaryAfterTax = 0;
  int _yearlyIncomeAfterTax = 0;

  @override
  void dispose() {
    _salaryController.dispose();
    _salaryYearController.dispose();
    super.dispose();
  }

  String _formatNumber(int number) {
    final formatter = NumberFormat('#,##0');
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
              'Salary Tax Calculator',
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
                child: Image.asset(
                  'assets/calculate.png',
                  width: 200, // Increase the width
                  height: 200, // Optional: Set height to maintain aspect ratio
                  fit: BoxFit.contain, // Adjust fit based on how you want it to scale
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Salary Tax Calculator $_selectedYear',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Overpass',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 00.0),
                  child: Text(
                    'This is the latest salary tax calculator as per $_selectedYear budget presented by the government of Pakistan.',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontFamily: 'Overpass',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => _showPeriodPicker(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedPeriod == 'monthly' ? "Monthly" : "Yearly",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => _showYearPicker(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedYear,
                        style: TextStyle(fontSize: 15, color: Colors.green[900]),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.green),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                cursorColor: Colors.green,
                controller: _selectedPeriod == 'monthly' ? _salaryController : _salaryYearController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5), // Default border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5), // Enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.green, width: 1.5), // Focused border
                  ),

                  labelText: _selectedPeriod == 'monthly' ? 'Enter Monthly Salary' : 'Enter Yearly Salary',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(13),
                ],
                onChanged: (value) {
                  _calculateTax();
                },
              ),
              SizedBox(height: 30),

              _buildResultTable(
                title: 'MONTHLY',
                income: _monthlySalary,
                tax: _monthlyTax,
                incomeAfterTax: _salaryAfterTax,
              ),
              SizedBox(height: 30),
              _buildResultTable(
                title: 'YEARLY',
                income: _yearlySalary,
                tax: _yearlyTax,
                incomeAfterTax: _yearlyIncomeAfterTax,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildResultTable({required String title, required int income, required int tax, required int incomeAfterTax}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildTableRow('Income', _formatNumber(income) + ' PKR'),
          _buildTableRow('Tax', _formatNumber(tax) + ' PKR'),
          _buildTableRow('Income After Tax', _formatNumber(incomeAfterTax) + ' PKR', isLast: true),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[900]),
          ),
        ],
      ),
    );
  }

  void _showPeriodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Monthly', 'Yearly'].map((String value) {
            return ListTile(
              title: Text(value),
              onTap: () {
                setState(() {
                  _selectedPeriod = value;
                  _salaryController.clear();
                  _salaryYearController.clear();
                  _calculateTax();
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showYearPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView( // This will enable scrolling
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <String>[
              '2024-2025',
              '2023-2024',
              '2022-2023',
              '2021-2022',
              '2020-2021',
              '2019-2020',
              '2018-2019',
              '2017-2018',
              '2016-2017',
              '2015-2016',
              '2014-2015',
            ].map((String value) {
              return ListTile(
                title: Text(value),
                onTap: () {
                  setState(() {
                    _selectedYear = value;
                    _calculateTax();
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }


  void _calculateTax() {
    int salary = int.tryParse(
        _selectedPeriod == 'monthly' ? _salaryController.text : _salaryYearController.text) ??
        0;

    if (_selectedPeriod == 'monthly') {
      _monthlySalary = salary;
      _yearlySalary = salary * 12;
      _yearlyTax = _calculateYearlyTax(_yearlySalary);
      _monthlyTax = _yearlyTax ~/ 12;
      _salaryAfterTax = _monthlySalary - _monthlyTax;
      _yearlyIncomeAfterTax = _yearlySalary - _yearlyTax;
    } else {
      _yearlySalary = salary;
      _monthlySalary = salary ~/ 12;
      _yearlyTax = _calculateYearlyTax(_yearlySalary);
      _monthlyTax = _yearlyTax ~/ 12;
      _salaryAfterTax = _monthlySalary - _monthlyTax;
      _yearlyIncomeAfterTax = _yearlySalary - _yearlyTax;
    }
    setState(() {});
  }

  int _calculateYearlyTax(int amount) {
    int taxAmount = 0;

    switch (_selectedYear) {
      case '2024-2025':
        taxAmount = _calculateTax24to25(amount);
        break;
      case '2023-2024':
        taxAmount = _calculateTax23to24(amount);
        break;
      case '2022-2023':
        taxAmount = _calculateTax22to23(amount);
        break;
      case '2021-2022':
        taxAmount = _calculateTax21to22(amount);
        break;
      case '2020-2021':
        taxAmount = _calculateTax20to21(amount);
        break;
      case '2019-2020':
        taxAmount = _calculateTax19to20(amount);
        break;
      case '2018-2019':
        taxAmount = _calculateTax18to19(amount);
        break;
      case '2017-2018':
        taxAmount = _calculateTax17to18(amount);
        break;
      case '2016-2017':
        taxAmount = _calculateTax16to17(amount);
        break;
      case '2015-2016':
        taxAmount = _calculateTax15to16(amount);
        break;
      case '2014-2015':
        taxAmount = _calculateTax14to15(amount);
        break;
    }

    return taxAmount;
  }

  int _calculateTax24to25(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.05).round();
    } else if (amount > 1200000 && amount <= 2200000) {
      amount -= 1200000;
      taxAmount = (30000 + amount * 0.15).round();
    } else if (amount > 2200000 && amount <= 3200000) {
      amount -= 2200000;
      taxAmount = (180000 + amount * 0.25).round();
    } else if (amount > 3200000 && amount <= 4100000) {
      amount -= 3200000;
      taxAmount = (430000 + amount * 0.30).round();
    } else if (amount > 4100000) {
      amount -= 4100000;
      taxAmount = (700000 + amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax23to24(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.025).round();
    } else if (amount > 1200000 && amount <= 2400000) {
      amount -= 1200000;
      taxAmount = (15000 + amount * 0.125).round();
    } else if (amount > 2400000 && amount <= 3600000) {
      amount -= 2400000;
      taxAmount = (165000 + amount * 0.225).round();
    } else if (amount > 3600000 && amount <= 6000000) {
      amount -= 3600000;
      taxAmount = (435000 + amount * 0.275).round();
    } else if (amount > 6000000) {
      amount -= 6000000;
      taxAmount = (1095000 + amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax22to23(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.025).round();
    } else if (amount > 1200000 && amount <= 2400000) {
      amount -= 1200000;
      taxAmount = (15000 + amount * 0.125).round();
    } else if (amount > 2400000 && amount <= 3600000) {
      amount -= 2400000;
      taxAmount = (165000 + amount * 0.2).round();
    } else if (amount > 3600000 && amount <= 6000000) {
      amount -= 3600000;
      taxAmount = (405000 + amount * 0.25).round();
    } else if (amount > 6000000 && amount <= 12000000) {
      amount -= 6000000;
      taxAmount = (1005000 + amount * 0.325).round();
    } else if (amount > 12000000) {
      amount -= 12000000;
      taxAmount = (2955000 + amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax21to22(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.05).round();
    } else if (amount > 1200000 && amount <= 1800000) {
      amount -= 1200000;
      taxAmount = 30000 + (amount * 0.10).round();
    } else if (amount > 1800000 && amount <= 2500000) {
      amount -= 1800000;
      taxAmount = 90000 + (amount * 0.15).round();
    } else if (amount > 2500000 && amount <= 3500000) {
      amount -= 2500000;
      taxAmount = 195000 + (amount * 0.175).round();
    } else if (amount > 3500000 && amount <= 5000000) {
      amount -= 3500000;
      taxAmount = 370000 + (amount * 0.2).round();
    } else if (amount > 5000000 && amount <= 8000000) {
      amount -= 5000000;
      taxAmount = 670000 + (amount * 0.225).round();
    } else if (amount > 8000000 && amount <= 12000000) {
      amount -= 8000000;
      taxAmount = 1345000 + (amount * 0.25).round();
    } else if (amount > 12000000 && amount <= 30000000) {
      amount -= 12000000;
      taxAmount = 2345000 + (amount * 0.275).round();
    } else if (amount > 30000000 && amount <= 50000000) {
      amount -= 30000000;
      taxAmount = 7295000 + (amount * 0.30).round();
    } else if (amount > 50000000 && amount <= 75000000) {
      amount -= 50000000;
      taxAmount = 13295000 + (amount * 0.325).round();
    } else if (amount > 75000000) {
      amount -= 75000000;
      taxAmount = 21420000 + (amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax20to21(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.05).round();
    } else if (amount > 1200000 && amount <= 1800000) {
      amount -= 1200000;
      taxAmount = 30000 + (amount * 0.10).round();
    } else if (amount > 1800000 && amount <= 2500000) {
      amount -= 1800000;
      taxAmount = 90000 + (amount * 0.15).round();
    } else if (amount > 2500000 && amount <= 3500000) {
      amount -= 2500000;
      taxAmount = 195000 + (amount * 0.175).round();
    } else if (amount > 3500000 && amount <= 5000000) {
      amount -= 3500000;
      taxAmount = 370000 + (amount * 0.2).round();
    } else if (amount > 5000000 && amount <= 8000000) {
      amount -= 5000000;
      taxAmount = 670000 + (amount * 0.225).round();
    } else if (amount > 8000000 && amount <= 12000000) {
      amount -= 8000000;
      taxAmount = 1345000 + (amount * 0.25).round();
    } else if (amount > 12000000 && amount <= 30000000) {
      amount -= 12000000;
      taxAmount = 2345000 + (amount * 0.275).round();
    } else if (amount > 30000000 && amount <= 50000000) {
      amount -= 30000000;
      taxAmount = 7295000 + (amount * 0.30).round();
    } else if (amount > 50000000 && amount <= 75000000) {
      amount -= 50000000;
      taxAmount = 13295000 + (amount * 0.325).round();
    } else if (amount > 75000000) {
      amount -= 75000000;
      taxAmount = 21420000 + (amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax19to20(int amount) {
    int taxAmount = 0;
    if (amount > 600000 && amount <= 1200000) {
      amount -= 600000;
      taxAmount = (amount * 0.05).round();
    } else if (amount > 1200000 && amount <= 1800000) {
      amount -= 1200000;
      taxAmount = 30000 + (amount * 0.10).round();
    } else if (amount > 1800000 && amount <= 2500000) {
      amount -= 1800000;
      taxAmount = 90000 + (amount * 0.15).round();
    } else if (amount > 2500000 && amount <= 3500000) {
      amount -= 2500000;
      taxAmount = 195000 + (amount * 0.175).round();
    } else if (amount > 3500000 && amount <= 5000000) {
      amount -= 3500000;
      taxAmount = 370000 + (amount * 0.2).round();
    } else if (amount > 5000000 && amount <= 8000000) {
      amount -= 5000000;
      taxAmount = 670000 + (amount * 0.225).round();
    } else if (amount > 8000000 && amount <= 12000000) {
      amount -= 8000000;
      taxAmount = 1345000 + (amount * 0.25).round();
    } else if (amount > 12000000 && amount <= 30000000) {
      amount -= 12000000;
      taxAmount = 2345000 + (amount * 0.275).round();
    } else if (amount > 30000000 && amount <= 50000000) {
      amount -= 30000000;
      taxAmount = 7295000 + (amount * 0.30).round();
    } else if (amount > 50000000 && amount <= 75000000) {
      amount -= 50000000;
      taxAmount = 13295000 + (amount * 0.325).round();
    } else if (amount > 75000000) {
      amount -= 75000000;
      taxAmount = 21420000 + (amount * 0.35).round();
    }
    return taxAmount;
  }

  int _calculateTax18to19(int amount) {
    int taxAmount = 0;
    if (amount > 400000 && amount <= 800000) {
      taxAmount = 1000;
    } else if (amount > 800000 && amount <= 1200000) {
      taxAmount = 2000;
    } else if (amount > 1200000 && amount <= 2500000) {
      amount -= 1200000;
      int taxAmount1 = (amount * 0.05).round();
      int taxAmount2 = 2000;
      taxAmount = taxAmount1 > taxAmount2 ? taxAmount1 : taxAmount2;
    } else if (amount > 2500000 && amount <= 4000000) {
      amount -= 2500000;
      taxAmount = 65000 + (amount * 0.15).round();
    } else if (amount > 4000000 && amount <= 8000000) {
      amount -= 4000000;
      taxAmount = 290000 + (amount * 0.2).round();
    } else if (amount > 8000000) {
      amount -= 8000000;
      taxAmount = 1090000 + (amount * 0.25).round();
    }
    return taxAmount;
  }

  int _calculateTax17to18(int amount) {
    int taxAmount = 0;
    if (amount > 400000 && amount <= 500000) {
      amount -= 400000;
      taxAmount = (amount * 0.02).round();
    } else if (amount > 500000 && amount <= 750000) {
      amount -= 500000;
      taxAmount = 2000 + (amount * 0.05).round();
    } else if (amount > 750000 && amount <= 1400000) {
      amount -= 750000;
      taxAmount = 14500 + (amount * 0.1).round();
    } else if (amount > 1400000 && amount <= 1500000) {
      amount -= 1400000;
      taxAmount = 79500 + (amount * 0.125).round();
    } else if (amount > 1500000 && amount <= 1800000) {
      amount -= 1500000;
      taxAmount = 92000 + (amount * 0.15).round();
    } else if (amount > 1800000 && amount < 2500000) {
      amount -= 1800000;
      taxAmount = 137000 + (amount * 0.175).round();
    } else if (amount > 2500000 && amount < 3000000) {
      amount -= 2500000;
      taxAmount = 259500 + (amount * 0.2).round();
    } else if (amount > 3000000 && amount < 3500000) {
      amount -= 3000000;
      taxAmount = 359500 + (amount * 0.225).round();
    } else if (amount > 3500000 && amount < 4000000) {
      amount -= 3500000;
      taxAmount = 472000 + (amount * 0.25).round();
    } else if (amount > 4000000 && amount < 7000000) {
      amount -= 4000000;
      taxAmount = 597000 + (amount * 0.275).round();
    } else if (amount > 7000000) {
      amount -= 7000000;
      taxAmount = 1422000 + (amount * 0.3).round();
    }
    return taxAmount;
  }

  int _calculateTax16to17(int amount) {
    int taxAmount = 0;
    if (amount > 400000 && amount <= 500000) {
      amount -= 400000;
      taxAmount = (amount * 0.02).round();
    } else if (amount > 500000 && amount <= 750000) {
      amount -= 500000;
      taxAmount = 2000 + (amount * 0.05).round();
    } else if (amount > 750000 && amount <= 1400000) {
      amount -= 750000;
      taxAmount = 14500 + (amount * 0.1).round();
    } else if (amount > 1400000 && amount <= 1500000) {
      amount -= 1400000;
      taxAmount = 79500 + (amount * 0.125).round();
    } else if (amount > 1500000 && amount <= 1800000) {
      amount -= 1500000;
      taxAmount = 92000 + (amount * 0.15).round();
    } else if (amount > 1800000 && amount < 2500000) {
      amount -= 1800000;
      taxAmount = 137000 + (amount * 0.175).round();
    } else if (amount > 2500000 && amount < 3000000) {
      amount -= 2500000;
      taxAmount = 259500 + (amount * 0.2).round();
    } else if (amount > 3000000 && amount < 3500000) {
      amount -= 3000000;
      taxAmount = 359500 + (amount * 0.225).round();
    } else if (amount > 3500000 && amount < 4000000) {
      amount -= 3500000;
      taxAmount = 472000 + (amount * 0.25).round();
    } else if (amount > 4000000 && amount < 7000000) {
      amount -= 4000000;
      taxAmount = 597000 + (amount * 0.275).round();
    } else if (amount > 7000000) {
      amount -= 7000000;
      taxAmount = 1422000 + (amount * 0.3).round();
    }
    return taxAmount;
  }

  int _calculateTax15to16(int amount) {
    int taxAmount = 0;
    if (amount > 400000 && amount <= 500000) {
      amount -= 400000;
      taxAmount = (amount * 0.02).round();
    } else if (amount > 500000 && amount <= 750000) {
      amount -= 500000;
      taxAmount = 2000 + (amount * 0.05).round();
    } else if (amount > 750000 && amount <= 1400000) {
      amount -= 750000;
      taxAmount = 14500 + (amount * 0.1).round();
    } else if (amount > 1400000 && amount <= 1500000) {
      amount -= 1400000;
      taxAmount = 79500 + (amount * 0.125).round();
    } else if (amount > 1500000 && amount <= 1800000) {
      amount -= 1500000;
      taxAmount = 92000 + (amount * 0.15).round();
    } else if (amount > 1800000 && amount < 2500000) {
      amount -= 1800000;
      taxAmount = 137000 + (amount * 0.175).round();
    } else if (amount > 2500000 && amount < 3000000) {
      amount -= 2500000;
      taxAmount = 259500 + (amount * 0.2).round();
    } else if (amount > 3000000 && amount < 3500000) {
      amount -= 3000000;
      taxAmount = 359500 + (amount * 0.225).round();
    } else if (amount > 3500000 && amount < 4000000) {
      amount -= 3500000;
      taxAmount = 472000 + (amount * 0.25).round();
    } else if (amount > 4000000 && amount < 7000000) {
      amount -= 4000000;
      taxAmount = 597000 + (amount * 0.275).round();
    } else if (amount > 7000000) {
      amount -= 7000000;
      taxAmount = 1422000 + (amount * 0.3).round();
    }
    return taxAmount;
  }

  int _calculateTax14to15(int amount) {
    int taxAmount = 0;
    if (amount > 400000 && amount <= 750000) {
      amount -= 400000;
      taxAmount = (amount * 0.05).round();
    } else if (amount > 750000 && amount <= 1400000) {
      amount -= 750000;
      taxAmount = 17500 + (amount * 0.1).round();
    } else if (amount > 1400000 && amount <= 1500000) {
      amount -= 1400000;
      taxAmount = 82500 + (amount * 0.125).round();
    } else if (amount > 1500000 && amount <= 1800000) {
      amount -= 1500000;
      taxAmount = 95000 + (amount * 0.15).round();
    } else if (amount > 1800000 && amount <= 2500000) {
      amount -= 1800000;
      taxAmount = 140000 + (amount * 0.175).round();
    } else if (amount > 2500000 && amount < 3000000) {
      amount -= 2500000;
      taxAmount = 262500 + (amount * 0.2).round();
    } else if (amount > 3000000 && amount < 3500000) {
      amount -= 3000000;
      taxAmount = 362500 + (amount * 0.225).round();
    } else if (amount > 3500000 && amount < 4000000) {
      amount -= 3500000;
      taxAmount = 475000 + (amount * 0.25).round();
    } else if (amount > 4000000 && amount < 7000000) {
      amount -= 4000000;
      taxAmount = 600000 + (amount * 0.275).round();
    } else if (amount > 7000000) {
      amount -= 7000000;
      taxAmount = 1425000 + (amount * 0.3).round();
    }
    return taxAmount;
  }

}
