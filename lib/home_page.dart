import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
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
              'Easy Tax Calculators',
              style: TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset('assets/logo.png', width: 320),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Tax Calculations Made Easy in Pakistan',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Overpass',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Text(
                  'Get the Accurate, efficient, and hassle-free 360° tax solutions at your fingertips. We are a tax preparation company in Pakistan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Overpass',
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _customIconButton(
                      context,
                      'Tax Calculators',
                      Icons.calculate,
                      '21 Calculators', // Custom description for this button
                      '/taxCalculators',
                      isLastChild: false, // First button
                    ),
                  ),
                  SizedBox(width: 20), // Space between buttons
                  Expanded(
                    child: _customIconButton(
                      context,
                      'Our Services',
                      Icons.miscellaneous_services,
                      'Available Services', // Different description for this button
                      'https://paktaxcalculator.pk/services/',
                      isLastChild: true, // Last button
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customIconButton(BuildContext context, String title, IconData icon, String description, String route, {bool isLastChild = false}) {
    return GestureDetector(
      onTap: () {
        if (route.startsWith('https')) {
          _launchURL(route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        margin: isLastChild
            ? EdgeInsets.only(right: 20, top: 10, bottom: 10) // Adjusted margins for last child
            : EdgeInsets.only(left: 20, top: 10, bottom: 10), // Adjusted margins for first child
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between content and arrow
          children: <Widget>[
            // Icon, title, and description in a column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
              children: <Widget>[
                Icon(icon, size: 60, color: Colors.green), // Icon at top
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ), // Main title text
                Text(
                  description, // Custom description text
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            // Arrow aligned to the top of the icon
            Icon(Icons.double_arrow_rounded, size: 34, color: Colors.green), // Arrow on the right
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
