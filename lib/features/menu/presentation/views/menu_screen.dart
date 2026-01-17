import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/shared widgets/food_card_widget.dart';
import '../../../../src/utils/constants.dart';
import '../../../../src/utils/extensions.dart';
import '../../../../src/shared widgets/custom_search_field.dart';
import '../../../../src/shared widgets/category_chip.dart';
import '../../../../src/shared widgets/badge_widget.dart';

/// Home Menu Screen
/// Main screen showing food categories, offers, and popular items
class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Pizza',
    'Burgers',
    'Salads',
    'Sushi',
    'Desserts',
  ];

  // Mock data - will be replaced with actual data from provider later
  final List<_FoodItem> _popularItems = [
    _FoodItem(
      id: '1',
      name: 'Artisanal Pepperoni',
      description: 'Classic wood-fired',
      price: 12.99,
      rating: 4.8,
      isHot: false,
    ),
    _FoodItem(
      id: '2',
      name: 'Truffle Beef Burger',
      description: 'Caramelized onions',
      price: 15.50,
      rating: 4.5,
      isHot: true,
    ),
    _FoodItem(
      id: '3',
      name: 'Rainbow Buddha Bowl',
      description: 'Organic & Vegan',
      price: 10.00,
      rating: 4.9,
      isHot: false,
    ),
    _FoodItem(
      id: '4',
      name: 'Salmon Nigiri Set',
      description: '8 pieces premium',
      price: 18.90,
      rating: 4.7,
      isHot: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    // TODO: Filter items by category
  }

  void _onSearchChanged(String query) {
    // TODO: Implement search
    print('Searching for: $query');
  }

  void _onFilterPressed() {
    context.showSnackBar('Filter pressed');
    // TODO: Show filter bottom sheet
  }

  void _onFoodItemTapped(String id) {
    // Navigate to food detail screen
    context.push('/food-detail/$id');
  }

  void _onAddToCart(String id) {
    context.showSuccessSnackBar('Added to cart!');
    // TODO: Add to cart logic
  }

  void _onNotificationPressed() {
    context.showSnackBar('Notifications coming soon');
  }

  void _onLocationPressed() {
    context.showSnackBar('Location selector coming soon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    _buildGreeting(),

                    const SizedBox(height: AppSpacing.lg),

                    // Search Bar
                    CustomSearchField(
                      controller: _searchController,
                      hintText: 'Search for your favorite dish...',
                      onChanged: _onSearchChanged,
                      onFilterPressed: _onFilterPressed,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Promo Banner
                    _buildPromoBanner(),

                    const SizedBox(height: AppSpacing.lg),

                    // Categories
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          return CategoryChip(
                            label: category,
                            icon: _getCategoryIcon(category),
                            isSelected: _selectedCategory == category,
                            onTap: () => _onCategorySelected(category),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Popular Now Section
                    _buildSectionHeader('Popular Now', onViewAll: () {
                      context.showSnackBar('View all coming soon');
                    }),

                    const SizedBox(height: AppSpacing.md),

                    // Food Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                      ),
                      itemCount: _popularItems.length,
                      itemBuilder: (context, index) {
                        final item = _popularItems[index];
                        return FoodCard(
                          id: item.id,
                          name: item.name,
                          description: item.description,
                          price: item.price,
                          rating: item.rating,
                          isHot: item.isHot,
                          onTap: () => _onFoodItemTapped(item.id),
                          onAddPressed: () => _onAddToCart(item.id),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Cart Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/cart'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.shopping_cart_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location
          GestureDetector(
            onTap: _onLocationPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DELIVER TO',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'San Francisco, CA',
                      style: AppTextStyles.labelLarge,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification Icon
          Stack(
            children: [
              IconButton(
                onPressed: _onNotificationPressed,
                icon: const Icon(Icons.notifications_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.h2,
            children: [
              const TextSpan(text: 'Good morning, '),
              TextSpan(
                text: 'Foodie!',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'What are you craving for today?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Badge
          Positioned(
            top: AppSpacing.md,
            left: AppSpacing.md,
            child: BadgeWidget.limitedOffer(),
          ),

          // Content
          Positioned(
            left: AppSpacing.md,
            bottom: AppSpacing.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '30% Off\nYour First\nOrder',
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton(
                  onPressed: () {
                    context.showSnackBar('Promo applied!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ),
                  child: const Text('Claim Now'),
                ),
              ],
            ),
          ),

          // Decorative Image Placeholder
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(AppSpacing.radiusLg),
              ),
              child: Container(
                width: 150,
                color: Colors.black12,
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.h3,
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: Text(
              'View all',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'All':
        return Icons.restaurant_menu_rounded;
      case 'Pizza':
        return Icons.local_pizza_rounded;
      case 'Burgers':
        return Icons.lunch_dining_rounded;
      case 'Salads':
        return Icons.eco_rounded;
      case 'Sushi':
        return Icons.set_meal_rounded;
      case 'Desserts':
        return Icons.cake_rounded;
      default:
        return Icons.fastfood_rounded;
    }
  }
}

// Mock Food Item Model (will move to proper models folder later)
class _FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final bool isHot;

  _FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.isHot = false,
  });
}
