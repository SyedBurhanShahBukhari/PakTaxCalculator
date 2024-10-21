import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgriTaxCalculatorsPage extends StatelessWidget {
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
              'Agricultural Tax Calculators',
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.center, // Center the last row
                  spacing: 20.0, // Horizontal spacing
                  runSpacing: 20.0, // Vertical spacing
                  children: [
                    CustomIconButton(
                      title: 'Punjab - Land',
                      icon: Icons.landscape,
                      description:
                      'Punjab tax calculator quickly figures out how much tax you owe for your farmland. It does this by looking at the value of your land and the current tax rates.',
                      route: '/agriTaxCalculatorLandPunjab',
                      isPro: true, // Add this flag to indicate PRO badge
                    ),
                    CustomIconButton(
                      title: 'Sindh - Land',
                      icon: Icons.landscape,
                      description: 'Sindh funds tax calculators help in determining the tax applicable on profits earned from various gains.',
                      route: '/agriTaxCalculatorLandSindh',
                      isPro: true, // No PRO badge
                    ),
                    CustomIconButton(
                      title: 'KPK - Land ',
                      icon: Icons.landscape,
                      description: 'KPK Tax on Properties Tax Calculators for determining your agricultural taxes efficiently.',
                      route: '/agriTaxCalculatorLandKpk',
                      isPro: true, // No PRO badge
                    ),
                    CustomIconButton(
                      title: 'Balochistan - Land',
                      icon: Icons.landscape,
                      description: 'Balochistan Tax Calculator for determining your agricultural taxes efficiently.',
                      route: '/agriTaxCalculatorLandBalochistan',
                      isPro: true, // No PRO badge
                    ),
                  //   Income
                    CustomIconButton(
                      title: 'Punjab - Income',
                      icon: Icons.landscape,
                      description:
                      'Punjab tax calculator quickly figures out how much tax you owe for your farmland. It does this by looking at the value of your land and the current tax rates.',
                      route: '/agriTaxCalculatorLandPunjab',
                      isPro: true, // Add this flag to indicate PRO badge
                    ),
                    CustomIconButton(
                      title: 'Sindh - Income',
                      icon: Icons.landscape,
                      description: 'Sindh funds tax calculators help in determining the tax applicable on profits earned from various gains.',
                      route: '/agriTaxCalculatorLandSindh',
                      isPro: true, // No PRO badge
                    ),
                    CustomIconButton(
                      title: 'KPK - Income',
                      icon: Icons.landscape,
                      description: 'KPK Tax on Properties Tax Calculators for determining your agricultural taxes efficiently.',
                      route: '/agriTaxCalculatorLandKpk',
                      isPro: true, // No PRO badge
                    ),
                    CustomIconButton(
                      title: 'Balochistan - Income',
                      icon: Icons.landscape,
                      description: 'Balochistan Tax Calculator for determining your agricultural taxes efficiently.',
                      route: '/agriTaxCalculatorLandBalochistan',
                      isPro: true, // No PRO badge
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
  final bool isPro;

  CustomIconButton({
    required this.title,
    required this.icon,
    required this.description,
    required this.route,
    this.isPro = false, // Default is no PRO badge
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
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9, // Full width
            padding: EdgeInsets.all(15), //djusted padding
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
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 08),
                      child: Icon(widget.icon, size: 25, color: Colors.green),

                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),  // Add margin here
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, size: 25, color: Colors.green),
                  ],
                ),
                SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: _isExpanded ? null : 30,
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
                      _isExpanded = !_isExpanded;
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
          if (widget.isPro)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
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
