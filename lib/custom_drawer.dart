  import 'package:flutter/material.dart';

  class CustomDrawer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // User account details
              _buildUserAccountHeader(),
              // Drawer items
              Divider(),

              _buildDrawerItem(Icons.home, 'Home', context),
              _buildDrawerItem(Icons.miscellaneous_services, 'Services', context),
              _buildDrawerItem(Icons.calculate_outlined, 'All Tax Calculators', context),
              _buildDrawerItem(Icons.support_agent, 'Support', context),
              // _buildDrawerItem(Icons.check_circle, 'Tasks', context),
              // _buildDrawerItem(Icons.receipt, 'Invoices', context),
              // _buildDrawerItem(Icons.sticky_note_2, 'Quotes', context),
              // _buildDrawerItem(Icons.work, 'Jobs', context),
              // _buildDrawerItem(Icons.notifications, 'Notifications', context),
              // Divider(),
              // // _buildDrawerItem(Icons.group, 'Refer a Friend', context),
              // _buildDrawerItem(Icons.settings, 'Settings', context),
            ],
          ),
        ),
      );
    }

    // Method to create the user account header
    Widget _buildUserAccountHeader() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green[100],
              child: Text(
                'TS',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              radius: 30, // Adjust the size of the avatar as needed
            ),
            SizedBox(width: 16.0), // Space between avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thomas Smith',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0), // Space between name and phone number
                Text(
                  '+1 718 395 5778',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }


    // Method to create individual drawer items
    Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
      return ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        hoverColor: Colors.green[50],
        onTap: () {
          // Handle navigation or other actions here
          Navigator.pop(context);
        },
      );
    }
  }
