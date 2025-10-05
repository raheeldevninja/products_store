import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:products_store/core/app/app_router.dart';
import 'package:products_store/core/app/product_store_app.dart';
import 'package:products_store/core/theme/bloc/theme_bloc.dart';
import 'package:products_store/core/theme/bloc/theme_event.dart';
import 'package:products_store/core/theme/data/theme_local_data_source.dart';
import 'package:products_store/core/theme/data/theme_repository_impl.dart';
import 'package:products_store/core/theme/domain/usecases/get_theme_mode.dart';
import 'package:products_store/core/theme/domain/usecases/set_theme_mode.dart';
import 'package:products_store/features/auth/domain/usecases/change_password.dart';
import 'package:products_store/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:products_store/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:products_store/features/cart/domain/usecases/add_to_cart.dart';
import 'package:products_store/features/cart/domain/usecases/clear_cart_items.dart';
import 'package:products_store/features/cart/domain/usecases/get_cart_items.dart';
import 'package:products_store/features/cart/domain/usecases/get_cart_total.dart';
import 'package:products_store/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:products_store/features/cart/domain/usecases/update_cart_quantity.dart';
import 'package:products_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:products_store/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:products_store/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:products_store/features/checkout/domain/usecases/cancel_checkout.dart';
import 'package:products_store/features/checkout/domain/usecases/confirm_checkout.dart';
import 'package:products_store/features/checkout/domain/usecases/create_checkout.dart';
import 'package:products_store/features/checkout/domain/usecases/get_user_checkouts.dart';
import 'package:products_store/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:products_store/features/product/data/data_sources/products_service.dart';
import 'package:uuid/uuid.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/send_password_reset.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/domain/entity/product.dart';
import 'firebase_options.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _uuid = const Uuid();


@pragma('vm:entry-point') // ensure not tree-shaken
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This runs in its own isolate
  await Firebase.initializeApp();
  // If your Cloud Function sends a `notification` payload, the system will display it automatically
  // For custom handling here you could log or persist message data
  debugPrint('Background message received: ${message.messageId}');
}



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //theme
  final localDataSource = ThemeLocalDataSourceImpl();
  final repository = ThemeRepositoryImpl(localDataSource);
  final getThemeMode = GetThemeMode(repository);
  final setThemeMode = SetThemeMode(repository);

  final themeBloc = ThemeBloc(
      getThemeMode, setThemeMode)..add(LoadThemeEvent(),
  );

  //auth
  final remote = AuthRemoteDataSource();
  final repo = AuthRepositoryImpl(remote);

  final authBloc = AuthBloc(
    signIn: SignIn(repo),
    signUp: SignUp(repo),
    sendPasswordReset: SendPasswordReset(repo),
    signOut: SignOut(repo),
    getCurrentUser: GetCurrentUser(repo),
    changePassword: ChangePassword(repo),
    repository: repo,
  );


  //cart
  final productsService = ProductsService(); // existing
  final cartRemote = CartRemoteDataSource(productsService: productsService);
  final cartRepo = CartRepositoryImpl(cartRemote);

  final getCartItems = GetCartItems(cartRepo);
  final addToCart = AddToCart(cartRepo);
  final removeFromCart = RemoveFromCart(cartRepo);
  final updateCartQuantity = UpdateCartQuantity(cartRepo);
  final getCartTotal = GetCartTotal(cartRepo);
  final clearCartItems = ClearCartItems(cartRepo);

  final cartBloc = CartBloc(
    getCartItems: getCartItems,
    addToCart: addToCart,
    removeFromCart: removeFromCart,
    updateCartQuantity: updateCartQuantity,
    getCartTotal: getCartTotal,
    clearCartItems: clearCartItems,
  );

  //checkout
  final checkoutRemote = CheckoutRemoteDataSource();
  final checkoutRepo = CheckoutRepositoryImpl(checkoutRemote);

  final checkoutBloc = CheckoutBloc(
    createCheckout: CreateCheckout(checkoutRepo),
    confirmCheckout: ConfirmCheckout(checkoutRepo),
    cancelCheckout: CancelCheckout(checkoutRepo),
    getUserCheckouts: GetUserCheckouts(checkoutRepo),
  );


  final router = createRouter(authBloc);

  //await addSampleProducts();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    ProductStoreApp(
      router: router,
      themeBloc: themeBloc,
      authBloc: authBloc,
      cartBloc: cartBloc,
      checkoutBloc: checkoutBloc,
    ),
  );
}


Future<void> addSampleProducts() async {
  final products = [
    Product(
      id: _uuid.v4(),
      name: "Wireless Headphones",
      description: "High-quality over-ear wireless headphones with noise cancellation.",
      price: 120.0,
      quantity: 12,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/headphones/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Smartphone",
      description: "Latest model smartphone with 5G and triple camera setup.",
      price: 999.0,
      quantity: 10,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/smartphone/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Laptop",
      description: "Slim and powerful laptop with 16GB RAM and 512GB SSD.",
      price: 1500.0,
      quantity: 20,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/laptop/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Smartwatch",
      description: "Stylish smartwatch with fitness tracking and heart-rate monitor.",
      price: 250.0,
      quantity: 34,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/smartwatch/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Bluetooth Speaker",
      description: "Portable waterproof speaker with high bass output.",
      price: 80.0,
      quantity: 34,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/speaker/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Gaming Mouse",
      description: "RGB gaming mouse with 7 programmable buttons.",
      price: 60.0,
      quantity: 30,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/mouse/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Mechanical Keyboard",
      description: "RGB backlit mechanical keyboard with blue switches.",
      price: 110.0,
      quantity: 44,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/keyboard/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "4K Monitor",
      description: "27-inch 4K UHD monitor with HDR support.",
      price: 350.0,
      quantity: 50,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/monitor/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Tablet",
      description: "Lightweight tablet with 10-inch display and pen support.",
      price: 450.0,
      quantity: 20,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/tablet/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Wireless Charger",
      description: "Fast wireless charging pad with 15W output.",
      price: 40.0,
      quantity: 20,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/charger/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Drone",
      description: "Camera drone with 4K video recording and GPS stabilization.",
      price: 800.0,
      quantity: 10,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/drone/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "DSLR Camera",
      description: "Professional DSLR with 24MP sensor and 4K video.",
      price: 1200.0,
      quantity: 5,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/camera/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Power Bank",
      description: "20,000mAh power bank with fast charging support.",
      price: 55.0,
      quantity: 23,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/powerbank/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "VR Headset",
      description: "Immersive virtual reality headset with 110° FOV.",
      price: 399.0,
      quantity: 8,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/vr/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "External SSD",
      description: "1TB portable SSD with USB-C interface.",
      price: 200.0,
      quantity: 18,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/ssd/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Smart TV",
      description: "55-inch 4K Smart TV with built-in streaming apps.",
      price: 700.0,
      quantity: 28,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/tv/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Fitness Tracker",
      description: "Wearable fitness tracker with sleep monitoring.",
      price: 90.0,
      quantity: 29,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/fitness/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Coffee Maker",
      description: "Automatic coffee machine with milk frother.",
      price: 250.0,
      quantity: 7,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/coffee/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Microwave Oven",
      description: "Compact microwave oven with grill function.",
      price: 180.0,
      quantity: 20,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/microwave/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
    Product(
      id: _uuid.v4(),
      name: "Air Purifier",
      description: "HEPA air purifier with smart app control.",
      price: 220.0,
      quantity: 20,
      currency: "USD",
      imageUrl: "https://picsum.photos/seed/air/300/200",
      createdAt: DateTime.now(),
      isActive: true,
    ),
  ];

  final batch = _firestore.batch();
  final collection = _firestore.collection("products");

  for (final product in products) {
    final docRef = collection.doc(product.id);
    batch.set(docRef, {
      "id": product.id,
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "quantity": product.quantity,
      "currency": product.currency,
      "imageUrl": product.imageUrl,
      "createdAt": product.createdAt,
      "isActive": product.isActive,
    });
  }

  await batch.commit();
  //print("✅ 20 sample products added successfully!");
}