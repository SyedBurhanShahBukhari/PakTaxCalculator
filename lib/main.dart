import 'package:flutter/material.dart';
import 'package:paktaxcalculator_app/purchase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:paktaxcalculator_app/punjab_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/punjab_land_tax_calculator.dart';
import 'package:paktaxcalculator_app/salary_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/sindh_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/sindh_land_tax_calculator.dart';
import 'package:paktaxcalculator_app/splash_screen.dart';
import 'package:paktaxcalculator_app/super_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/welcome_screen.dart';
import 'package:paktaxcalculator_app/home_page.dart';
import 'package:paktaxcalculator_app/tax_calculators_page.dart';
import 'package:paktaxcalculator_app/agri_tax_calculators_page.dart';
import 'package:paktaxcalculator_app/withholding_properties_tax_calculator.dart';
import 'package:paktaxcalculator_app/withholding_tax_calculator.dart';
import 'package:paktaxcalculator_app/balochistan_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/balochistan_land_tax_calculator.dart';
import 'package:paktaxcalculator_app/builder_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/business_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/companies_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/developer_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/freelancer_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/gain_funds_tax_calculator.dart';
import 'package:paktaxcalculator_app/gain_properties_tax_calculator.dart';
import 'package:paktaxcalculator_app/gain_security_tax_calculator.dart';
import 'package:paktaxcalculator_app/gain_tax_calculators_page.dart';
import 'package:paktaxcalculator_app/income_tax_calculators_page.dart';
import 'package:paktaxcalculator_app/kpk_income_tax_calculator.dart';
import 'package:paktaxcalculator_app/kpk_land_tax_calculator.dart';
import 'package:paktaxcalculator_app/login_page.dart';
import 'package:paktaxcalculator_app/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyA7XHskh0Y_eaU7cjHTtnC_Iw35KAqvH_Q",
          authDomain: "pakistantaxcalculator.firebaseapp.com",
          projectId: "pakistantaxcalculator",
          storageBucket: "pakistantaxcalculator.appspot.com",
          messagingSenderId: "674833002497",
          appId: "1:674833002497:web:1256c14f4259d080f5d000",
          measurementId: "G-0X29NRMC6N",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    runApp(PakTaxCalculatorApp());
  } catch (e) {
    print("Firebase initialization failed with error: $e");
  }
}


class PakTaxCalculatorApp extends StatefulWidget {
  @override
  _PakTaxCalculatorAppState createState() => _PakTaxCalculatorAppState();
}

class _PakTaxCalculatorAppState extends State<PakTaxCalculatorApp> {
  bool _isPremiumUser = false;  // This should come from your purchase checking service

  @override
  void initState() {
    super.initState();
    _checkIfUserIsPremium();  // Check if the user has purchased premium features
  }

  // Simulate checking the purchase status (you'd replace this with real logic)
  void _checkIfUserIsPremium() async {
    bool isPremium = await PurchaseService().isUserPremium();  // This would check actual purchase status
    setState(() {
      _isPremiumUser = isPremium;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PakTaxCalculator',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(), // Set SplashScreen as the initial screen
      routes: {
        '/splash': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
        '/LoginPage': (context) => LoginPage(),
        '/CreateAccount': (context) => CreateAccountPage(),
        '/taxCalculators': (context) => TaxCalculatorsPage(),
        '/incomeTaxCalculators': (context) => IncomeTaxCalculatorsPage(),
        '/gainTaxCalculators': (context) => GainTaxCalculatorsPage(),
        '/agriTaxCalculators': (context) => AgriTaxCalculatorsPage(),

        // Free calculators
        '/agriTaxCalculatorIncomePunjab': (context) => PunjabIncomeTaxCalculator(),
        '/agriTaxCalculatorIncomeSindh': (context) => SindhIncomeTaxCalculator(),
        '/agriTaxCalculatorIncomeKpk': (context) => KPKIncomeTaxCalculator(),
        '/agriTaxCalculatorIncomeBalochistan': (context) => BalochistanIncomeTaxCalculator(),
        '/gainTaxCalculators': (context) => GainTaxCalculatorsPage(),
        '/gainSecurityTaxCalculators': (context) => GainSecurityTaxCalculator(),
        '/gainFundTaxCalculators': (context) => CapitalGainFundsTaxCalculator(),
        '/gainPropertiesTaxCalculators': (context) => CapitalGainPropertiesTaxCalculator(),
        '/WithholdingPropertiesTaxCalculators': (context) => WithholdingPropertiesTaxCalculator(),
        '/WithholdingTaxCalculators': (context) => WithholdingTaxCalculator(),
        '/incomeTaxCalculators': (context) => IncomeTaxCalculatorsPage(),
        '/salaryIncomeTaxCalculators': (context) => SalaryTaxCalculator(),
        '/businessIncomeTaxCalculators': (context) => BusinessTaxCalculator(),
        '/freelancerIncomeTaxCalculators': (context) => FreelancerTaxCalculator(),
        '/developerIncomeTaxCalculators': (context) => DeveloperTaxCalculator(),
        '/builderIncomeTaxCalculators': (context) => BuilderTaxCalculator(),

        // Premium calculators
        '/agriTaxCalculatorLandPunjab': (context) => _isPremiumUser
            ? PunjabLandTaxCalculator()
            : _showPaywall(context),
        '/agriTaxCalculatorLandSindh': (context) => _isPremiumUser
            ? SindhLandTaxCalculator()
            : _showPaywall(context),
        '/agriTaxCalculatorLandKpk': (context) => _isPremiumUser
            ? KpkLandTaxCalculator()
            : _showPaywall(context),
        '/agriTaxCalculatorLandBalochistan': (context) => _isPremiumUser
            ? BalochistanLandTaxCalculator()
            : _showPaywall(context),
        '/superIncomeTaxCalculators': (context) => _isPremiumUser
            ? SuperTaxCalculator()
            : _showPaywall(context),
        '/companiesIncomeTaxCalculators': (context) => _isPremiumUser
            ? CompaniesTaxCalculator()
            : _showPaywall(context),
      },
    );
  }

  // Method to show a paywall when accessing premium calculators
  Widget _showPaywall(BuildContext context) {
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
              '',
              style: TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Premium Access Required',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 20),
              Text(
                'This calculator is available for premium users only.',
                style: TextStyle(fontSize: 18, color: Colors.green[600]),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  PurchaseService().purchasePremiumCalculator();  // Ensure this method exists in your PurchaseService
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: Icon(Icons.lock_open, color: Colors.white),
                label: Text(
                  'Unlock Premium Features',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
