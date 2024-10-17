import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TaxCalculatorsPage extends StatelessWidget {
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
              'All Tax Calculators',
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
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/logo.png', width: 320),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Tax Calculations Made Easy in Pakistan',
                  style: TextStyle(
                    fontSize: 40, // Reduced for modern look
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Overpass',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Text(
                  'Get the Accurate, efficient, and hassle-free 360° tax solutions at your fingertips. We are a tax preparation company in Pakistan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, // Modernized size
                    fontFamily: 'Overpass',
                    color: Colors.grey[700], // Softer color for text
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.center, // Center the last row
                  spacing: 20.0, // Horizontal spacing
                  runSpacing: 20.0, // Vertical spacing
                  children: [
                    CustomIconButton(
                      title: 'Income Tax',
                      icon: Icons.money,
                      description:
                      'ltural Land Tax calculator quickly figures out how much tax you owe for your farmland. It does this by looking at the value of your land and the current tax rates.',
                      route: '/incomeTaxCalculators',
                    ),
                    CustomIconButton(
                      title: 'Gain Tax',
                      icon: Icons.price_change_outlined,
                      description: 'Gain Tax calculators help in determining the tax applicable on profits earned from various gains.',
                      route: '/gainTaxCalculators',
                    ),
                    CustomIconButton(
                      title: 'Agricultural Tax',
                      icon: Icons.agriculture,
                      description: '8 Calculators for determining your agricultural taxes efficiently.',
                      route: '/agriTaxCalculators',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;
  final String route;

  CustomIconButton({
    required this.title,
    required this.icon,
    required this.description,
    required this.route,
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.route.startsWith('https')) {
          _launchURL(widget.route);
        } else {
          Navigator.pushNamed(context, widget.route);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42, // Responsive size for mobile
        padding: EdgeInsets.all(15), // Adjusted padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Softer shadow for modern look
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(widget.icon, size: 40, color: Colors.green), // Smaller icon size
                Icon(Icons.arrow_forward_rounded, size: 25, color: Colors.green),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Modern text color
              ),
            ),
            SizedBox(height: 5),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _isExpanded ? null : 30, // Limit height initially
              child: Text(
                widget.description,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded; // Toggle expanded state
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  _isExpanded ? "Show Less" : "Show More",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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
