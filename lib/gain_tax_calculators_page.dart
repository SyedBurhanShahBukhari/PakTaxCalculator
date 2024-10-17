import 'package:flutter/material.dart';

class GainTaxCalculatorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Gain Tax Calculators',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                // Gain Tax on Securities
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/gainSecurityTaxCalculators');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button background color
                      foregroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.monetization_on, color: Colors.white, size: 24), // Updated icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Gain Tax on Securities',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Overpass',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white), // Icon at the end
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing between buttons

                // Gain Tax on Mutual Fund
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/gainFundTaxCalculators');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.green, // Text color
                      side: BorderSide(color: Colors.green, width: 2), // Green border
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_balance_wallet, color: Colors.green, size: 24), // Updated icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Gain Tax on Mutual Fund',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Overpass',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Colors.green), // Icon at the end
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing between buttons

                // Gain Tax on Properties
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/gainPropertiesTaxCalculators');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.green, // Text color
                      side: BorderSide(color: Colors.green, width: 2), // Green border
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.house, color: Colors.green, size: 24), // Updated icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Gain Tax on Properties',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Overpass',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Colors.green), // Icon at the end
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing between buttons

                // Withholding Tax on Income from Properties
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/WithholdingPropertiesTaxCalculators');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.green, // Text color
                      side: BorderSide(color: Colors.green, width: 2), // Green border
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.real_estate_agent, color: Colors.green, size: 24), // Updated icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'WH Tax on Properties',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Overpass',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Colors.green), // Icon at the end
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing between buttons

                // Withholding Tax On Brokerage & Commission Tax Calculator
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/WithholdingTaxCalculators');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.green, // Text color
                      side: BorderSide(color: Colors.green, width: 2), // Green border
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.business_center, color: Colors.green, size: 24), // Updated icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'WH Tax On Brokerage',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Overpass',
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Colors.green), // Icon at the end
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Spacing between buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
