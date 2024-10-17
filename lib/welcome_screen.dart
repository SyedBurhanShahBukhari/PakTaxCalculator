
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:paktaxcalculator_app/custom_drawer.dart';
import 'package:paktaxcalculator_app/hexagonal_icon_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoggedIn = false; // Track the login status of the user

  final List<String> bannerImages = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF7F7F7),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(context),
            const SizedBox(height: 20),
            BannerSlider(bannerImages: bannerImages), // Reusable BannerSlider widget
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            _buildTextSection(
              'Tax Calculations Made Easy in Pakistan',
              42,
              FontWeight.bold,
            ),
            const SizedBox(height: 10),
            _buildTextSection(
              'Get the Accurate, efficient, and hassle-free 360° tax solutions at your fingertips.',
              20,
            ),
            const SizedBox(height: 30),
            // CustomButton(
            //   text: 'Start',
            //   icon: Icons.arrow_forward,
            //   onPressed: () => Navigator.pushNamed(context, '/home'),
            // ),
            //
            SizedBox(
              width: 400,
              height: 80, // Increased height for description space
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Adding a container to wrap the icon for background color
                        Container(
                          width: 48, // Adjust as needed for spacing
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F4F3), // Background color for the icon
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/start.png',
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Overpass',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Add The Description', // Add the description text here
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Overpass',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),
            SizedBox(
              width: 400,
              height: 80, // Increased height for description space
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '#');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Adding a container to wrap the icon for background color
                        Container(
                          width: 48, // Adjust as needed for spacing
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F4F3), // Background color for the icon
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/more.png',
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'More',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Overpass',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Add The Description', // Add the description text here
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Overpass',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            _buildIconButtonRow(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Build the header with menu and profile icons
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon with white background, border-radius, and shadow
          Container(
            width: 45, // Set the width for the icon container
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(12), // Border radius of 15
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  blurRadius: 5, // Softness of the shadow
                  offset: Offset(0, 3), // Horizontal and vertical offset of the shadow
                ),
              ],
            ),
            child: IconButton(
              icon: Image.asset('assets/menu.png', width: 24),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          // Profile Icon with Custom Border Radius
          GestureDetector(
            onTap: () {
              // Show a popup menu for login/logout based on the login status
              _showProfileMenu(context);
            },
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 03),
                  width: 45, // Set the width for the icon container
                  height: 45, // Set the height for the icon container
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(12), // Border radius of 12
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        blurRadius: 5, // Softness of the shadow
                        offset: Offset(0, 3), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: CircleAvatar(
                      radius: 15, // Set the radius for the avatar
                      backgroundColor: Colors.transparent, // Make the background transparent
                      backgroundImage: _isLoggedIn
                          ? NetworkImage('https://your-profile-image-url.com') // User profile image if logged in
                          : AssetImage('assets/user.png') as ImageProvider, // Default icon if not logged in
                    ),
                    iconSize: 44, // Adjust icon size if needed
                    onPressed: () => _showProfileMenu(context),
                  ),
                ),

                const SizedBox(height: 5), // Space between image and icon
                // Icon(
                //   _isLoggedIn ? Icons.logout : Icons.login, // Show logout icon if logged in, login icon otherwise
                //   color: Colors.green, // Icon color
                //   size: 20, // Icon size
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Show the profile menu based on login status
  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _isLoggedIn
                ? [
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.green, // Set the icon color to green
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Overpass',
                    color: Colors.green, // Set the text color to green
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _isLoggedIn = false; // Update the login status
                  });
                  Navigator.pop(context); // Close the bottom sheet
                  // Additional logout logic goes here
                },
              ),
            ]
                : [
              ListTile(
                leading: Icon(
                  Icons.login,
                  color: Colors.green, // Set the icon color to green
                ),
                title: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Overpass',
                    color: Colors.green, // Set the text color to green
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/LoginPage');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_add,
                  color: Colors.green, // Set the icon color to green
                ),
                title: Text(
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Overpass',
                    color: Colors.green, // Set the text color to green
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/CreateAccount');
                },
              ),

            ],
          ),
        );
      },
    );
  }


  Widget _buildTextSection(String text, double fontSize, [FontWeight fontWeight = FontWeight.normal]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, fontFamily: 'Overpass'),
      ),
    );
  }

  Widget _buildIconButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HexagonalIconButton(
          icon: Icons.star,
          size: 60,
          color: Colors.green,
          onPressed: () => print("Play Store Rating clicked"),
        ),
        HexagonalIconButton(
          icon: Icons.exit_to_app,
          size: 60,
          color: Colors.green,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HexagonalIconButton(
          icon: Icons.lock,
          size: 60,
          color: Colors.green,
          onPressed: () => Navigator.pushNamed(context, '/LoginPage'),
        ),
      ],
    );
  }
}

class BannerSlider extends StatelessWidget {
  final List<String> bannerImages;

  const BannerSlider({required this.bannerImages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 0,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
      items: bannerImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(i),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
