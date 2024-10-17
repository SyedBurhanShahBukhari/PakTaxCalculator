import 'package:flutter/material.dart';

class AgriTaxCalculatorsPage extends StatelessWidget {
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
          'Agri Tax Calculators',
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
                // Punjab - Land
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorLandPunjab');
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
                            Icon(Icons.landscape, color: Colors.white, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Punjab - Land',
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

                // Sindh - Land
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorLandSindh');
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
                            Icon(Icons.landscape, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Sindh - Land',
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

                // KPK - Land
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorLandKpk');
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
                            Icon(Icons.landscape, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'KPK - Land',
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

                // Balochistan - Land
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorLandBalochistan');
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
                            Icon(Icons.landscape, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Balochistan - Land',
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

                // Punjab - Income
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorIncomePunjab');
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
                            Icon(Icons.account_balance, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Punjab - Income',
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

                // Sindh - Income
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorIncomeSindh');
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
                            Icon(Icons.account_balance, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Sindh - Income',
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

                // KPK - Income
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorIncomeKpk');
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
                            Icon(Icons.account_balance, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'KPK - Income',
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

                // Balochistan - Income
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to specific calculator
                      Navigator.pushNamed(context, '/agriTaxCalculatorIncomeBalochistan');
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
                            Icon(Icons.account_balance, color: Colors.green, size: 24), // Replace with appropriate icon
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'Balochistan - Income',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
