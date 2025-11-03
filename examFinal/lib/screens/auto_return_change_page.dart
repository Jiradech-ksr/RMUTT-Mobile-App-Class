import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeCalculatorPage extends StatefulWidget {
  const ChangeCalculatorPage({super.key});

  @override
  State<ChangeCalculatorPage> createState() => _ChangeCalculatorPageState();
}

class _ChangeCalculatorPageState extends State<ChangeCalculatorPage> {
  // --- Items ---
  // We now use a list of maps to hold the state of each item
  final List<Map<String, dynamic>> _items = [
    {'name': 'Item 1', 'price': 50, 'quantity': 0},
    {'name': 'Item 2', 'price': 22, 'quantity': 0},
    {'name': 'Item 3', 'price': 5, 'quantity': 0},
  ];

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controller for cash
  final _cashController = TextEditingController();

  // State variables to hold the results
  int _totalPrice = 0; // This will now be calculated from the items list
  int _totalChange = 0;
  String _errorMessage = '';
  bool _isError = false; // To distinguish error messages from success messages
  // Map to store the breakdown: {denomination: count}
  final Map<int, int> _changeBreakdown = {};
  final List<int> _denominations = [500, 100, 50, 20, 10, 5, 2, 1];

  @override
  void dispose() {
    // Clean up cash controller
    _cashController.dispose();
    super.dispose();
  }

  // --- Item & Price Logic ---
  void _updateItemQuantity(int index, int change) {
    setState(() {
      int currentQuantity = _items[index]['quantity'];
      // Only update if the new quantity is not negative
      if (currentQuantity + change >= 0) {
        _items[index]['quantity'] = currentQuantity + change;
        _updateTotalPrice();
        _clearResults(); // Clear old change results if cart changes
      }
    });
  }

  void _updateTotalPrice() {
    int total = 0;
    for (var item in _items) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }
    // No setState needed, as this is called from within _updateItemQuantity
    _totalPrice = total;
  }

  // Helper to clear results when cart changes
  void _clearResults() {
    setState(() {
      _totalChange = 0;
      _errorMessage = '';
      _isError = false;
      _changeBreakdown.clear();
    });
  }

  // --- Core Calculation Logic ---
  void _calculateChange() {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Reset results
    setState(() {
      _totalChange = 0;
      _errorMessage = '';
      _isError = false;
      _changeBreakdown.clear();
    });

    // Safely parse cash, defaulting to 0 if empty
    final int cash = int.tryParse(_cashController.text) ?? 0;

    // --- Calculate price from state ---
    final int price = _totalPrice;
    final int change = cash - price;

    // --- Validation ---
    if (price == 0) {
      setState(() {
        _errorMessage = 'Your cart is empty. Please add at least one item.';
        _isError = true;
      });
      return;
    }

    if (cash == 0) {
      setState(() {
        _errorMessage = 'Please enter the cash tendered.';
        _isError = true;
      });
      return;
    }

    if (change < 0) {
      setState(() {
        _errorMessage =
            'Insufficient cash! Customer still owes ${change.abs()}.';
        _isError = true;
      });
      return;
    }

    if (change == 0) {
      setState(() {
        _errorMessage = 'Exact amount paid. No change due.';
        _isError = false; // This is a success message
      });
      return;
    }

    // --- Calculate Breakdown ---
    int remainingChange = change;
    final Map<int, int> breakdown = {};

    for (int denom in _denominations) {
      int count = remainingChange ~/ denom; // Integer division
      if (count > 0) {
        breakdown[denom] = count;
        remainingChange = remainingChange % denom; // Get remainder
      }
    }

    // --- Update State to display results ---
    setState(() {
      _totalChange = change;
      _changeBreakdown.addAll(breakdown);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Calculator'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // --- Input Card ---
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- Display Dynamic Items ---
                    ..._items.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      return _buildItemRow(
                        name: item['name'],
                        price: item['price'],
                        quantity: item['quantity'],
                        onRemove: () => _updateItemQuantity(index, -1),
                        onAdd: () => _updateItemQuantity(index, 1),
                      );
                    }),
                    // ---
                    const Divider(height: 16),
                    _buildPriceRow(
                      'TOTAL PRICE:',
                      '$_totalPrice',
                      isTotal: true,
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    // --- Cash Input ---
                    _buildNumberTextField(
                      controller: _cashController,
                      label: 'Cash Tendered',
                      isRequired: true,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculateChange,
                      child: const Text('Calculate Change'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // --- Results Display ---
            _buildResults(),
          ],
        ),
      ),
    );
  }

  // --- Helper widget for item row with +/- buttons ---
  Widget _buildItemRow({
    required String name,
    required int price,
    required int quantity,
    required VoidCallback onRemove,
    required VoidCallback onAdd,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Item Name & Price
          Text('$name ($price)', style: const TextStyle(fontSize: 16)),
          // --- Quantity Controls ---
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onRemove,
                color: Colors.red.shade600,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(
                width: 24, // Fixed width for alignment
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onAdd,
                color: Colors.green.shade600,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Helper widget for price display ---
  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    final style = TextStyle(
      fontSize: 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: isTotal ? Colors.blue.shade800 : Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  // --- Helper widget for text fields ---
  Widget _buildNumberTextField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      // Only allow digits
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  // --- Helper widget to build the results section ---
  Widget _buildResults() {
    // If there's an error, show it
    if (_errorMessage.isNotEmpty) {
      final cardColor = _isError ? Colors.red.shade50 : Colors.green.shade50;
      final textColor = _isError ? Colors.red.shade800 : Colors.green.shade800;

      return Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      );
    }

    // If there's no change, show nothing
    if (_totalChange == 0) {
      return const SizedBox.shrink();
    }

    // --- Build the full results card ---
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Summary ---
            _buildResultRow('Total Price:', '$_totalPrice'),
            _buildResultRow('Cash Tendered:', _cashController.text),
            const Divider(height: 24),
            _buildResultRow(
              'TOTAL CHANGE:',
              '$_totalChange'
                  '\tBATH',
              isHeader: true,
            ),
            const SizedBox(height: 16),

            // --- Breakdown ---
            const Text(
              'Change Breakdown:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._changeBreakdown.entries.map((entry) {
              final denom = entry.key;
              final count = entry.value;
              final type = denom >= 20 ? 'Banknote' : 'Coin';
              return ListTile(
                title: Text('$type $denom'),
                trailing: Text(
                  'x $count',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                dense: true,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool isHeader = false}) {
    final style = TextStyle(
      fontSize: isHeader ? 20 : 16,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: isHeader ? Colors.blue.shade800 : Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
