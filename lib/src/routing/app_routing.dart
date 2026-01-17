import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_management_system/features/auth/presentation/views/login_screen.dart';
import 'package:restaurant_management_system/features/menu/presentation/views/home_menu_screen.dart';
import 'package:restaurant_management_system/features/menu/presentation/views/menu_screen.dart';
import 'package:restaurant_management_system/features/orders/presentation/views/orders_empty_screen.dart';

import '../../features/splash/presentation/views/splash_screen.dart';

/// Centralized routing configuration using GoRouter
///
/// This router handles all navigation in the app with:
/// - Named routes for easy navigation
/// - Deep linking support
/// - Type-safe route parameters
/// - Nested navigation (tabs, etc.)

class AppRouter {
  AppRouter._(); // Private constructor

  // Route names as constants for type safety
  static const String splash = '/';
  // static const String auth = '/auth';
  static const String login = '/login';
  static const String home = '/home';
  static const String restaurantBrowse = '/restaurants';
  static const String restaurantDetail = '/restaurant/:id';
  static const String menu = '/menu';
  static const String menuItemDetail = '/menu/:id';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String noOrders = '/noOrders';
  static const String orderDetail = '/order/:id';
  static const String profile = '/profile';
  static const String settings = '/settings';

  /// Create the GoRouter instance
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: home,
      debugLogDiagnostics: kDebugMode, // Enable in development

      // Error page handler
      errorBuilder: (context, state) => ErrorPage(error: state.error),

      routes: [
        // Splash Screen
        GoRoute(
          path: splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        //login
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),

        // Authentication
        // GoRoute(
        //   path: auth,
        //   name: 'auth',
        //   builder: (context, state) => const AuthScreen(),
        // ),

        // Main App Shell with Bottom Navigation
        ShellRoute(
          builder: (context, state, child) {
            return MainAppShell(child: child);
          },
          routes: [
            // Home / Restaurant Browse
            GoRoute(
              path: home,
              name: 'home',
              builder: (context, state) => const HomeMenuScreen(),
              // routes: [
              //   // Restaurant Detail (nested under home)
              //   GoRoute(
              //     path: 'restaurant/:id',
              //     name: 'restaurantDetail',
              //     builder: (context, state) {
              //       final id = state.pathParameters['id']!;
              //       return RestaurantDetailScreen(restaurantId: id);
              //     },
              //   ),
              // ],
            ),

            // Detailed Menu
            GoRoute(
              path: menu,
              name: 'menu',
              builder: (context, state) => const MenuScreen(),
              // routes: [
              //   // Menu Item Detail
              //   GoRoute(
              //     path: 'item/:id',
              //     name: 'menuItemDetail',
              //     builder: (context, state) {
              //       final id = state.pathParameters['id']!;
              //       return MenuItemDetailScreen(itemId: id);
              //     },
              //   ),
              // ],
            ),

            // Cart
            GoRoute(
              path: cart,
              name: 'cart',
              builder: (context, state) => const CartScreen(),
              // routes: [
              //   // Checkout
              //   GoRoute(
              //     path: 'checkout',
              //     name: 'checkout',
              //     builder: (context, state) => const CheckoutScreen(),
              //   ),
              // ],
            ),

            // // Orders
            GoRoute(
              path: orders,
              name: 'orders',
              builder: (context, state) => const OrdersScreen(),
              // routes: [
              //   // Order Detail
              //   GoRoute(
              //     path: ':id',
              //     name: 'orderDetail',
              //     builder: (context, state) {
              //       final id = state.pathParameters['id']!;
              //       return OrderDetailScreen(orderId: id);
              //     },
              //   ),
              // ],
            ),

            GoRoute(
              path: noOrders,
              name: 'noOrders',
              builder: (context, state) => const OrdersEmptyView(),
            ),

            // // Profile
            GoRoute(
              path: profile,
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
              // routes: [
              //   // Settings
              //   GoRoute(
              //     path: 'settings',
              //     name: 'settings',
              //     builder: (context, state) => const SettingsScreen(),
              //   ),
              // ],
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// PLACEHOLDER SCREENS (Replace with actual implementations)
// ============================================================================

class MainAppShell extends StatefulWidget {
  final Widget child;

  const MainAppShell({
    super.key,
    required this.child,
  });

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() => _currentIndex = index);

    // Navigate based on index
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.menu);
        break;
      case 2:
        context.go(AppRouter.cart);
        break;
      case 3:
        context.go(AppRouter.noOrders);
        break;
      case 4:
        context.go(AppRouter.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// class RestaurantBrowseScreen extends StatelessWidget {
//   const RestaurantBrowseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Restaurant Browse Screen'),
//       ),
//     );
//   }
// }

// class RestaurantDetailScreen extends StatelessWidget {
//   final String restaurantId;

//   const RestaurantDetailScreen({
//     super.key,
//     required this.restaurantId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Restaurant $restaurantId')),
//       body: Center(
//         child: Text('Restaurant Detail: $restaurantId'),
//       ),
//     );
//   }
// }

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Menu Screen'),
//       ),
//     );
//   }
// }

// class MenuItemDetailScreen extends StatelessWidget {
//   final String itemId;

//   const MenuItemDetailScreen({
//     super.key,
//     required this.itemId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Menu Item $itemId')),
//       body: Center(
//         child: Text('Menu Item Detail: $itemId'),
//       ),
//     );
//   }
// }

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: const Center(
        child: Text('Checkout Screen'),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Orders Screen'),
      ),
    );
  }
}

// class OrderDetailScreen extends StatelessWidget {
//   final String orderId;

//   const OrderDetailScreen({
//     super.key,
//     required this.orderId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Order $orderId')),
//       body: Center(
//         child: Text('Order Detail: $orderId'),
//       ),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (error != null)
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
