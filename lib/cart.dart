import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// ─── Cart Item Model ──────────────────────────────────────────────────────────
class CartItem {
  final int? dbId;
  final String name;
  final String image;
  final int price;
  int quantity;

  CartItem({
    this.dbId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  int get total => price * quantity;

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      dbId: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}

// ─── Cart Manager ─────────────────────────────────────────────────────────────
class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];
  bool isLoading = false;
  String? lastError;

  List<CartItem> get items => List.unmodifiable(_items);
  int get totalCount => _items.fold(0, (sum, item) => sum + item.quantity);
  int get totalPrice => _items.fold(0, (sum, item) => sum + item.total);

  // ── Load cart from Supabase (only called once at app start) ─────────────
  Future<void> loadFromSupabase() async {
    isLoading = true;
    lastError = null;
    notifyListeners();
    try {
      final response = await supabase
          .from('producttable')
          .select()
          .order('id', ascending: true);
      _items.clear();
      for (final row in response) {
        _items.add(CartItem.fromMap(row));
      }
      debugPrint('✅ Loaded ${_items.length} items from Supabase');
    } catch (e) {
      lastError = e.toString();
      debugPrint('❌ Load error: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // ── Add item ────────────────────────────────────────────────────────────
  Future<bool> addItem(Map<String, dynamic> product) async {
    final int originalPrice = product['price'];
    final int discount = product['discount'] ?? 0;
    final int discountedPrice =
        (originalPrice * (1 - discount / 100)).round();

    // Check in-memory list first (no extra DB round-trip)
    final existing =
        _items.where((i) => i.name == product['name']).toList();

    if (existing.isNotEmpty) {
      // Already in cart → update quantity in DB then memory
      final item = existing.first;
      final newQty = item.quantity + 1;
      try {
        await supabase
            .from('producttable')
            .update({'quantity': newQty}).eq('id', item.dbId!);
        item.quantity = newQty;
        notifyListeners();
        debugPrint('✅ Updated quantity: ${item.name} → $newQty');
        return true;
      } catch (e) {
        debugPrint('❌ Update error: $e');
        return false;
      }
    } else {
      // New item → insert into DB, then add to memory using returned row
      try {
        final response = await supabase
            .from('producttable')
            .insert({
              'name': product['name'],
              'image': product['image'],
              'price': discountedPrice,
              'quantity': 1,
            })
            .select()
            .single();

        _items.add(CartItem.fromMap(response));
        notifyListeners();
        debugPrint('✅ Inserted: ${product['name']}');
        return true;
      } catch (e) {
        debugPrint('❌ Insert error: $e');
        return false;
      }
    }
  }

  // ── Increase quantity ───────────────────────────────────────────────────
  Future<void> increaseItem(CartItem item) async {
    final newQty = item.quantity + 1;
    try {
      await supabase
          .from('producttable')
          .update({'quantity': newQty}).eq('id', item.dbId!);
      item.quantity = newQty;
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Increase error: $e');
    }
  }

  // ── Decrease quantity ───────────────────────────────────────────────────
  Future<void> decreaseItem(String name) async {
    final existing = _items.where((i) => i.name == name).toList();
    if (existing.isEmpty) return;

    final item = existing.first;
    if (item.quantity > 1) {
      final newQty = item.quantity - 1;
      try {
        await supabase
            .from('producttable')
            .update({'quantity': newQty}).eq('id', item.dbId!);
        item.quantity = newQty;
        notifyListeners();
      } catch (e) {
        debugPrint('❌ Decrease error: $e');
      }
    } else {
      await removeItem(name);
    }
  }

  // ── Remove item ─────────────────────────────────────────────────────────
  Future<void> removeItem(String name) async {
    final existing = _items.where((i) => i.name == name).toList();
    if (existing.isEmpty) return;

    try {
      await supabase
          .from('producttable')
          .delete()
          .eq('id', existing.first.dbId!);
      _items.removeWhere((i) => i.name == name);
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Remove error: $e');
    }
  }

  // ── Clear all (single query, not a loop) ───────────────────────────────
  Future<void> clearCart() async {
    try {
      await supabase.from('producttable').delete().neq('id', 0);
      _items.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Clear error: $e');
    }
  }
}

// ─── Cart Page ────────────────────────────────────────────────────────────────
class CartPage extends StatefulWidget {
  final CartManager cart;
  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    widget.cart.addListener(_refresh);
    // ✅ FIX: Do NOT call loadFromSupabase() here.
    // The CartManager singleton already has the correct in-memory state
    // from when addItem() was called on the home page.
    // Calling loadFromSupabase() here would wipe that state with a stale DB read.
  }

  @override
  void dispose() {
    widget.cart.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  String _fmt(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  void _checkout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text("Order Placed! 🎉"),
          ],
        ),
        content: Text(
          "Thank you for your order!\n\n"
          "Total: LKR ${_fmt(widget.cart.totalPrice)}\n\n"
          "We will contact you shortly.",
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await widget.cart.clearCart();
              if (context.mounted) Navigator.pop(context);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.cart.items;

    if (widget.cart.isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading cart...",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "🛒 Cart (${widget.cart.totalCount} items)",
          style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          if (items.isNotEmpty)
            TextButton.icon(
              icon: const Icon(Icons.delete_sweep, color: Colors.white),
              label: const Text("Clear",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Clear Cart?"),
                    content: const Text(
                        "Are you sure you want to remove all items?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await widget.cart.clearCart();
                          if (context.mounted) Navigator.pop(context);
                        },
                        child: const Text("Clear"),
                      ),
                    ],
                  ),
                );
              },
            ),
          const SizedBox(width: 8),
        ],
      ),

      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Your cart is empty",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey)),
                  SizedBox(height: 8),
                  Text("Add some products to get started!",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        // Product image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.image,
                            width: 65,
                            height: 65,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 65,
                              height: 65,
                              color: Colors.grey[200],
                              child: const Icon(Icons.computer,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Name + price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(
                                "LKR ${_fmt(item.price)} each",
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        // Quantity controls
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.orange),
                              onPressed: () =>
                                  widget.cart.decreaseItem(item.name),
                            ),
                            Text('${item.quantity}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.green),
                              onPressed: () =>
                                  widget.cart.increaseItem(item),
                            ),
                          ],
                        ),

                        // Item total
                        SizedBox(
                          width: 100,
                          child: Text(
                            "LKR ${_fmt(item.total)}",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),

                        // Remove button
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () =>
                              widget.cart.removeItem(item.name),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // ── Bottom Total + Checkout Bar ──────────────────────────────────────
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2))
                ],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey)),
                      Text(
                        "LKR ${_fmt(widget.cart.totalPrice)}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.payment),
                    label: const Text("Checkout",
                        style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _checkout,
                  ),
                ],
              ),
            ),
    );
  }
}