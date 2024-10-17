import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';  // Android-specific imports

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _isAvailable = false;
  bool _isPremiumUser = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  // This is your product ID for premium calculators
  static const String _premiumProductId = 'premium_calculator_1';

  factory PurchaseService() {
    return _instance;
  }

  PurchaseService._internal();

  // Initialize the in-app purchase connection
  Future<void> initialize() async {
    _isAvailable = await _iap.isAvailable();
    if (_isAvailable) {
      await _loadProducts();
      _listenToPurchaseUpdates();
      await restorePurchases(); // Optional, can keep this for checking past purchases
    } else {
      print('In-app purchases are not available.');
    }
  }


  // Load available products (premium calculators)
  Future<void> _loadProducts() async {
    const Set<String> _productIds = {_premiumProductId};
    final ProductDetailsResponse response = await _iap.queryProductDetails(_productIds);
    if (response.notFoundIDs.isNotEmpty) {
      print('Products not found: ${response.notFoundIDs}');
    }
    _products = response.productDetails;
  }

  // Listen for purchase updates (whether the user completes a purchase)
  void _listenToPurchaseUpdates() {
    final purchaseStream = InAppPurchase.instance.purchaseStream;
    purchaseStream.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    });
  }

  // Handle purchase updates
  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        _verifyPurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        _handlePurchaseError(purchase.error!);
      }
    }
    _purchases.addAll(purchases);
  }

  // Verify and finalize purchase
  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    if (purchase.productID == _premiumProductId) {
      _isPremiumUser = true;
      _iap.completePurchase(purchase);
      print('Premium access unlocked!');
    }
  }

  // Handle purchase errors
  void _handlePurchaseError(IAPError error) {
    print('Error during purchase: ${error.message}');
    // You could show a message to the user here
  }

  // Trigger the purchase flow for the premium calculator
  Future<void> purchasePremiumCalculator() async {
    if (_products.isNotEmpty) {
      final ProductDetails product = _products.firstWhere((prod) => prod.id == _premiumProductId);
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);

      // Initiate the purchase
      try {
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      } catch (e) {
        print('Error initiating purchase: $e');  // Handle any errors
      }
    } else {
      print('No products available for purchase');
    }
  }


  // Check if the user is premium
  bool isUserPremium() {
    return _isPremiumUser;
  }

  // Restore purchases when the user reinstalls the app or changes devices (for Android)
  Future<void> restorePurchases() async {
    if (await InAppPurchase.instance.isAvailable()) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
      InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();

      final QueryPurchaseDetailsResponse response = await androidAddition.queryPastPurchases();
      for (PurchaseDetails purchase in response.pastPurchases) {
        if (purchase.productID == _premiumProductId && purchase.status == PurchaseStatus.purchased) {
          _isPremiumUser = true;
        }
      }
      // iOS automatically restores purchases, so no need to call restore here.
    }
  }
}
