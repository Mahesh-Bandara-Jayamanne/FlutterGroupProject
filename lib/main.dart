import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wakakjpkznoxxtlhjxzb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indha2FranBrem5veHh0bGhqeHpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ3Nzc3NDQsImV4cCI6MjA5MDM1Mzc0NH0.OjhuPOrwW6HDBbz5ykjF6py8TceKPN1ZhxIQbycLEn4',
  );
  runApp(const MBJComputersApp());
}

// ─── App Root ─────────────────────────────────────────────────────────────────
class MBJComputersApp extends StatelessWidget {
  const MBJComputersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MBJ 77 PRO COMPUTERS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// ─── Home Page ────────────────────────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // ================= LAPTOPS =================
  static const List<Map<String, dynamic>> laptops = [
    {"name": "Dell XPS 13", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjNijVNdIXq6l_jNpQeA5zG3rXfqhvSPdZ2Q&s", "price": 280000, "discount": 10},
    {"name": "HP Pavilion", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8L6P-lRUeY9_vXbGj0C6GQoUMGD6vCM_bpA&s", "price": 220000, "discount": 5},
    {"name": "MacBook Pro", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFD4kJt8hHJpqRe0_bnLGtP-cAtUqKsYfG5g&s", "price": 450000, "discount": 15},
    {"name": "Asus VivoBook", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgqsXniQMtJwsKRoJm6WwWt-tFNXbbcZa6vw&s", "price": 180000, "discount": 8},
    {"name": "Lenovo ThinkPad", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL3-LMDJnS_J7GJ-5s4aX5pWTIBz0FGo6sQQ&s", "price": 250000, "discount": 10},
    {"name": "Acer Swift", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvJq4c-Qq93SsVP3L1Hp1-CKxJRNGJjLbFdA&s", "price": 170000, "discount": 7},
    {"name": "MSI Prestige", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmgwRN9jk0Y8J7c-oILZt0LVZpJxEi1Hcq8g&s", "price": 350000, "discount": 12},
    {"name": "Razer Blade", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlDXtMqalNP2Hum2GkiVH6EgNfNFYn_xMbQA&s", "price": 420000, "discount": 15},
    {"name": "Huawei MateBook", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJFq5wRNfS2DlAiKj5MeKM0Z7Fw5vloBHOQQ&s", "price": 230000, "discount": 8},
    {"name": "LG Gram", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnLP0ZMjP7eFH8vqQFH7N7D7MpZjqBfuabMA&s", "price": 280000, "discount": 10},
    {"name": "Samsung Galaxy Book", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFGiqsYTPwflJOd1MQiHW9l3lECNV63wBx4Q&s", "price": 260000, "discount": 7},
    {"name": "Chromebook", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7J2PFHbVJJ7sPYKMLh_XCjwXFVjYaUXbxkQ&s", "price": 95000, "discount": 5},
    {"name": "Dell Inspiron", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkHiLYIpCn1cJrKLiNg_7QZuqmKJgb3U1bwQ&s", "price": 190000, "discount": 8},
    {"name": "HP EliteBook", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo5HYsXhPJ8MWKJxY_LnEz5E0VVwxYiAP6Lg&s", "price": 280000, "discount": 10},
    {"name": "Asus ROG", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHcfqwBSI6AV-_hAJpZ4j_f8R9fQGfO0mVpQ&s", "price": 400000, "discount": 12},
    {"name": "Lenovo Yoga", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEwJ0LPeTi3E3lC8TDpLMg9zQ7k3G9Ks6M3g&s", "price": 240000, "discount": 7},
  ];

  // ================= DESKTOPS =================
  static const List<Map<String, dynamic>> desktops = [
    {"name": "Gaming PC", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSooBrmV7eliW3uQ5EqipezDCVVPaKTibazwA&s", "price": 400000, "discount": 15},
    {"name": "Office PC", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4nQsMg3rCWjE8l0L_j6S4G4fDiKcDPt4Kzw&s", "price": 180000, "discount": 5},
    {"name": "All-in-One", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKSO5TJXSvLqnrGGqx0JlS2V8y7H7G3r-nWw&s", "price": 320000, "discount": 12},
    {"name": "Mini PC", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSooBrmV7eliW3uQ5EqipezDCVVPaKTibazwA&s", "price": 120000, "discount": 7},
    {"name": "Workstation", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTim7a_xW62Yh3tt6c_WnKjJkGJ_0ku_1vXWw&s", "price": 550000, "discount": 18},
    {"name": "Gaming Tower", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqhZZhgdbBk_KIXq5uinasB0RCyD9X-rcr_Q&s", "price": 420000, "discount": 10},
    {"name": "Mac Mini", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoBmXWVE7Ys5LX5r7L9nXh_H5v5X6_7RmhBQ&s", "price": 350000, "discount": 12},
    {"name": "Dell OptiPlex", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQ25kiwIaOsDT0_bhTWgLUl6hwo33eLbQQg&s", "price": 200000, "discount": 8},
    {"name": "HP ProDesk", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQ25kiwIaOsDT0_bhTWgLUl6hwo33eLbQQg&s", "price": 210000, "discount": 7},
    {"name": "Acer Predator", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkCy9ZQ-YBJu6uvpjkzdPgb9UKGuAjenGSA&s", "price": 380000, "discount": 15},
    {"name": "Lenovo IdeaCentre", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSooBrmV7eliW3uQ5EqipezDCVVPaKTibazwA&s", "price": 230000, "discount": 6},
    {"name": "Custom Build 1", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqhZZhgdbBk_KIXq5uinasB0RCyD9X-rcr_Q&s", "price": 450000, "discount": 10},
    {"name": "Custom Build 2", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkCy9ZQ-YBJu6uvpjkzdPgb9UKGuAjenGSA&s", "price": 470000, "discount": 12},
    {"name": "Gaming Rig 1", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqhZZhgdbBk_KIXq5uinasB0RCyD9X-rcr_Q&s", "price": 500000, "discount": 15},
    {"name": "Gaming Rig 2", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkCy9ZQ-YBJu6uvpjkzdPgb9UKGuAjenGSA&s", "price": 520000, "discount": 18},
    {"name": "HP Pavilion AiO", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQ25kiwIaOsDT0_bhTWgLUl6hwo33eLbQQg&s", "price": 300000, "discount": 10},
  ];

  // ================= ACCESSORIES =================
  static const List<Map<String, dynamic>> others = [
    {"name": "Keyboard", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUGJKe2kYq2lJ7x1KyS5y6VDl8OJl6-ZmYoA&s", "price": 5000, "discount": 5},
    {"name": "Mouse", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_M7zhPTbBnmt7Nai7kwCQryebmZwVHZL-vQ&s", "price": 3500, "discount": 7},
    {"name": "Monitor", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7j2pFHbVJJ7sPYKMLh_XCjwXFVjYaUXbxkQ&s", "price": 60000, "discount": 10},
    {"name": "Headset", "image": "https://m.media-amazon.com/images/I/61CGHv6kmWL._AC_SL1500_.jpg", "price": 15000, "discount": 8},
    {"name": "Printer", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo5HYsXhPJ8MWKJxY_LnEz5E0VVwxYiAP6Lg&s", "price": 40000, "discount": 12},
    {"name": "Webcam", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeVq3HNDsihna9lr1ibnDGw71xG-lWJScwdw&s", "price": 12000, "discount": 5},
    {"name": "Speaker", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0L6CM8NDb2C4nNxUHctW1SE6_Pdi8tkOxXQ&s", "price": 20000, "discount": 10},
    {"name": "UPS", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX4Llrx7wS7mW5AGBYEgZTmCwbI2I-QAmbMg&s", "price": 30000, "discount": 8},
    {"name": "Router", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoczHlIMZg78wIW590YQh3kJjDtvm13Q4P5A&s", "price": 15000, "discount": 5},
    {"name": "External HDD", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX4Llrx7wS7mW5AGBYEgZTmCwbI2I-QAmbMg&s", "price": 25000, "discount": 10},
    {"name": "USB Hub", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgqsXniQMtJwsKRoJm6WwWt-tFNXbbcZa6vw&s", "price": 4000, "discount": 5},
    {"name": "Cooling Pad", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTszxA0j8az8U22eTPBXRg6_iACwWwKKESFcg&s", "price": 5500, "discount": 8},
    {"name": "Laptop Stand", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPlaVLbFuc-fBDWdQ4gOVWLq6Ptb9xuxBL6A&s", "price": 7000, "discount": 10},
    {"name": "Power Bank", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkHiLYIpCn1cJrKLiNg_7QZuqmKJgb3U1bwQ&s", "price": 6000, "discount": 7},
    {"name": "Memory Card", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkQpnyjZbLVNBBvFJUNyxX9yKSi3L7L4wo7w&s", "price": 3000, "discount": 5},
    {"name": "Microphone", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeVq3HNDsihna9lr1ibnDGw71xG-lWJScwdw&s", "price": 8000, "discount": 8},
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartManager _cart = CartManager();
  bool _showSaleOnly = false;

  @override
  void initState() {
    super.initState();
    _cart.addListener(_onCartChanged);
    // ✅ Load existing cart from Supabase once on app start (e.g. items from last session)
    _cart.loadFromSupabase();
  }

  @override
  void dispose() {
    _cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() => setState(() {});

  List<Map<String, dynamic>> _filtered(List<Map<String, dynamic>> items) {
    if (!_showSaleOnly) return items;
    return items.where((item) => item['discount'] >= 10).toList();
  }

  // ── Add to cart ────────────────────────────────────────────────────────────
  Future<void> _addToCart(Map<String, dynamic> product) async {
    // ✅ FIX: addItem now returns bool so we can show success OR error snackbar
    final success = await _cart.addItem(product);
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();

    if (!success) {
      // Show error if Supabase insert failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Failed to add item. Check your Supabase connection.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${product["name"]} added to cart!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _openCart();
              },
              child: const Text(
                "VIEW CART",
                style: TextStyle(
                    color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ── Open Cart Page ─────────────────────────────────────────────────────────
  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartPage(cart: _cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "MBJ 77 PRO COMPUTERS",
          style: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 175, 3, 3),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart,
                    color: Colors.black87, size: 30),
                onPressed: _openCart,
                tooltip: 'View Cart',
              ),
              if (_cart.totalCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_cart.totalCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          // ── Welcome Banner ───────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color.fromARGB(255, 160, 195, 243),
            child: const Text(
              "Welcome to the Computer Park",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 27, 15),
                  fontWeight: FontWeight.bold),
            ),
          ),

          // ── Nav Buttons ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text("Home"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _showSaleOnly ? Colors.grey[300] : Colors.blue,
                    foregroundColor:
                        _showSaleOnly ? Colors.black : Colors.white,
                  ),
                  onPressed: () => setState(() => _showSaleOnly = false),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.local_offer),
                  label: const Text("Sale"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _showSaleOnly ? Colors.red : Colors.grey[300],
                    foregroundColor:
                        _showSaleOnly ? Colors.white : Colors.black,
                  ),
                  onPressed: () =>
                      setState(() => _showSaleOnly = !_showSaleOnly),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: Text("Cart (${_cart.totalCount})"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _openCart,
                ),
              ],
            ),
          ),

          // Sale banner
          if (_showSaleOnly)
            Container(
              width: double.infinity,
              color: Colors.red[100],
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: const Text(
                "🔥  SALE — Showing items with 10%+ discount!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),

          // ── Product Grid ─────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildSection("💻 Laptops", _filtered(HomePage.laptops)),
                _buildSection("🖥️ Desktops", _filtered(HomePage.desktops)),
                _buildSection(
                    "🔌 Accessories & Others", _filtered(HomePage.others)),
              ],
            ),
          ),

          // ── Footer ───────────────────────────────────────────────────────
          Container(
            color: Colors.black,
            padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _FooterItem(
                        icon: Icons.location_on,
                        label: "Kandy, Peradeniya Rd, Buwalikada"),
                    _FooterItem(
                        icon: Icons.email,
                        label: "mbj77primax@gmail.com"),
                    _FooterItem(
                        icon: Icons.phone,
                        label: "0762672418 / 0762672419"),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "© 2026 MBJ 77 PRO COMPUTERS — Trusted • Reliable • Efficient",
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Section builder ────────────────────────────────────────────────────────
  Widget _buildSection(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text("No items on sale in this category.",
                style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return DeviceCard(
              product: item,
              onAdd: () async => await _addToCart(item),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ─── Device Card ──────────────────────────────────────────────────────────────
class DeviceCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAdd;

  const DeviceCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final int price = product['price'];
    final int discount = product['discount'];
    final int discountedPrice = (price * (1 - discount / 100)).round();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1), blurRadius: 5)
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product['image'],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.computer,
                      size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['name'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "LKR ${_formatNum(discountedPrice)}",
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  if (discount > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LKR ${_formatNum(price)}",
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "-$discount%",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add_shopping_cart, size: 12),
                      label: const Text("Add",
                          style: TextStyle(fontSize: 10)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 4),
                        minimumSize: const Size(0, 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    final s = n.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
      buffer.write(s[i]);
    }
    return buffer.toString();
  }
}

// ─── Footer Item ──────────────────────────────────────────────────────────────
class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FooterItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}