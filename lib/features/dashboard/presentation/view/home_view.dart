import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/cart_view.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/menu_view.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/notification_view.dart';
import 'package:flaviourfleet/features/dashboard/presentation/view/profile_view.dart';
import 'package:flaviourfleet/features/dashboard/presentation/viewmodel/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flaviourfleet/features/dashboard/presentation/state/dashboard_state.dart';

class HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !isLoading) {
      setState(() {
        isLoading = true;
      });
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    await ref
        .read(dashboardViewModelProvider.notifier)
        .getPosts(page: currentPage);
    setState(() {
      isLoading = false;
      currentPage++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuView()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileView()),
        );
        break;
    }
  }

  void _navigateToNotificationView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Namaste, ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: _navigateToNotificationView,
              icon: const Icon(
                Icons.notifications,
                size: 32,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search for restaurants, cuisines...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Today\'s Specials',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: state.lstposts.map((post) {
                  String imageUrl =
                      '${ApiEndpoints.imageUrl}${post.productImage}';
                  print('Image URL: $imageUrl'); // Debugging statement
                  return _buildSpecialItem(
                    post.productName,
                    imageUrl,
                    'Price: Rs ${post.productPrice}',
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Explore Restaurants',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...state.lstposts.map((post) {
              String imageUrl = '${ApiEndpoints.imageUrl}${post.productImage}';
              print('Image URL: $imageUrl'); // Debugging statement
              return _buildRestaurantCategory(
                post.productName,
                imageUrl,
              );
            }),
            if (state.hasReachedMax)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'No more products available',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orangeAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.orangeAccent),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.orangeAccent),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orangeAccent),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.orange[50],
      ),
    );
  }

  Widget _buildSpecialItem(String title, String imagePath, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: 180,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 180,
                  height: 180,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCategory(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
