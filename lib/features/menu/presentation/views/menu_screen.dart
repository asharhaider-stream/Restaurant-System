import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../src/shared widgets/cutom_app_bar.dart';
import '../../../../src/shared widgets/food_card_widget.dart';
import '../../../../src/utils/constants.dart';
import '../../../../src/utils/extensions.dart';
import '../../../../src/shared widgets/custom_search_field.dart';
import '../../../../src/shared widgets/category_chip.dart';

/// Menu Screen
/// Complete food catalog with filters, sorting and categories
/// Different from Home - shows ALL items, not just popular
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _searchController = TextEditingController();

  // Filter states (clickable but UI stays same for now)
  String _selectedCategory = 'All';
  String _selectedSortOption = 'Popular';
  final Set<String> _selectedFilters = {};

  final List<String> _categories = [
    'All',
    'Pizza',
    'Burgers',
    'Salads',
    'Sushi',
    'Desserts',
    'Beverages',
  ];

  final List<String> _sortOptions = [
    'Popular',
    'Rating',
    'Price: Low to High',
    'Price: High to Low',
    'Delivery Time',
  ];

  final List<String> _quickFilters = [
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Under \$15',
    'Fast Delivery',
  ];

  // Extended mock data - full catalog
  final List<_MenuItem> _allMenuItems = [
    _MenuItem(
      id: '1',
      name: 'Artisanal Pepperoni',
      description: 'Classic wood-fired pizza',
      price: 12.99,
      rating: 4.8,
      category: 'Pizza',
      isHot: false,
    ),
    _MenuItem(
      id: '2',
      name: 'Truffle Beef Burger',
      description: 'Caramelized onions, aged cheddar',
      price: 15.50,
      rating: 4.5,
      category: 'Burgers',
      isHot: true,
    ),
    _MenuItem(
      id: '3',
      name: 'Rainbow Buddha Bowl',
      description: 'Organic vegetables & quinoa',
      price: 10.00,
      rating: 4.9,
      category: 'Salads',
      isHot: false,
    ),
    _MenuItem(
      id: '4',
      name: 'Salmon Nigiri Set',
      description: '8 pieces premium sushi',
      price: 18.90,
      rating: 4.7,
      category: 'Sushi',
      isHot: false,
    ),
    _MenuItem(
      id: '5',
      name: 'Margherita Classic',
      description: 'Fresh mozzarella & basil',
      price: 11.50,
      rating: 4.6,
      category: 'Pizza',
      isNew: true,
    ),
    _MenuItem(
      id: '6',
      name: 'BBQ Chicken Burger',
      description: 'Grilled chicken, smoky sauce',
      price: 13.99,
      rating: 4.4,
      category: 'Burgers',
    ),
    _MenuItem(
      id: '7',
      name: 'Caesar Salad',
      description: 'Romaine, parmesan, croutons',
      price: 9.50,
      rating: 4.3,
      category: 'Salads',
    ),
    _MenuItem(
      id: '8',
      name: 'Tuna Roll Combo',
      description: '12 pieces assorted rolls',
      price: 16.50,
      rating: 4.8,
      category: 'Sushi',
      isHot: true,
    ),
    _MenuItem(
      id: '9',
      name: 'Chocolate Lava Cake',
      description: 'Warm molten center',
      price: 7.99,
      rating: 4.9,
      category: 'Desserts',
      isNew: true,
    ),
    _MenuItem(
      id: '10',
      name: 'Iced Matcha Latte',
      description: 'Japanese green tea',
      price: 5.50,
      rating: 4.7,
      category: 'Beverages',
    ),
    _MenuItem(
      id: '11',
      name: 'Veggie Supreme Pizza',
      description: 'Bell peppers, olives, mushrooms',
      price: 13.50,
      rating: 4.5,
      category: 'Pizza',
    ),
    _MenuItem(
      id: '12',
      name: 'Double Smash Burger',
      description: 'Two patties, special sauce',
      price: 14.99,
      rating: 4.8,
      category: 'Burgers',
      isHot: true,
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

  void _onFilterToggle(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
    // TODO: Apply filters
  }

  void _onSortOptionSelected() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSortBottomSheet(),
    );
  }

  void _onSearchChanged(String query) {
    // TODO: Implement search
    print('Searching: $query');
  }

  void _onFilterPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildFilterBottomSheet(),
    );
  }

  void _onFoodItemTapped(String id) {
    context.push('/food-detail/$id');
  }

  void _onAddToCart(String id) {
    context.showSuccessSnackBar('Added to cart!');
    // TODO: Add to cart logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Menu',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push('/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                // Search Bar
                CustomSearchField(
                  controller: _searchController,
                  hintText: 'Search dishes, cuisines...',
                  onChanged: _onSearchChanged,
                  onFilterPressed: _onFilterPressed,
                ),

                const SizedBox(height: AppSpacing.md),

                // Quick Filters Row
                SizedBox(
                  height: 36,
                  child: Row(
                    children: [
                      // Sort Button
                      _buildSortButton(),

                      const SizedBox(width: AppSpacing.sm),

                      // Divider
                      Container(
                        width: 1,
                        height: 24,
                        color: AppColors.border,
                      ),

                      const SizedBox(width: AppSpacing.sm),

                      // Quick Filter Chips
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _quickFilters.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: AppSpacing.xs),
                          itemBuilder: (context, index) {
                            final filter = _quickFilters[index];
                            final isSelected =
                                _selectedFilters.contains(filter);
                            return _buildFilterChip(filter, isSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Categories
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
            ),
            child: SizedBox(
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
          ),

          // Results Count
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_allMenuItems.length} dishes available',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (_selectedFilters.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilters.clear();
                      });
                    },
                    child: Text(
                      'Clear filters',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Food Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: _allMenuItems.length,
              itemBuilder: (context, index) {
                final item = _allMenuItems[index];
                return FoodCard(
                  id: item.id,
                  name: item.name,
                  description: item.description,
                  price: item.price,
                  rating: item.rating,
                  isHot: item.isHot,
                  isNew: item.isNew,
                  onTap: () => _onFoodItemTapped(item.id),
                  onAddPressed: () => _onAddToCart(item.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortButton() {
    return GestureDetector(
      onTap: _onSortOptionSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sort_rounded,
              size: AppSpacing.iconSm,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 4),
            Text(
              _selectedSortOption,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _onFilterToggle(label),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort by',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: AppSpacing.md),
          ...List.generate(_sortOptions.length, (index) {
            final option = _sortOptions[index];
            final isSelected = _selectedSortOption == option;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                option,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedSortOption = option;
                });
                context.pop();
                context.showSnackBar('Sorted by: $option');
              },
            );
          }),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildFilterBottomSheet() {
    return Container(
      height: context.screenHeight * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: AppTextStyles.h4,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedFilters.clear();
                  });
                },
                child: Text(
                  'Clear all',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Filter Content (Placeholder)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dietary Preferences',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children:
                        ['Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free']
                            .map((filter) => _buildFilterChip(
                                  filter,
                                  _selectedFilters.contains(filter),
                                ))
                            .toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Price Range',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: ['Under \$10', '\$10-\$20', 'Over \$20']
                        .map((filter) => _buildFilterChip(
                              filter,
                              _selectedFilters.contains(filter),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Delivery',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: ['Fast Delivery', 'Free Delivery']
                        .map((filter) => _buildFilterChip(
                              filter,
                              _selectedFilters.contains(filter),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          // Apply Button
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.showSnackBar(
                    '${_selectedFilters.length} filters applied',
                  );
                },
                child: Text(
                  'Apply Filters (${_selectedFilters.length})',
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ),
        ],
      ),
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
      case 'Beverages':
        return Icons.local_cafe_rounded;
      default:
        return Icons.fastfood_rounded;
    }
  }
}

// Mock Menu Item Model
class _MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final bool isHot;
  final bool isNew;

  _MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    this.isHot = false,
    this.isNew = false,
  });
}
