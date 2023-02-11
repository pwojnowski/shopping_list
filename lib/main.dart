import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Shopping List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Product {
  String name;
  bool bought = false;
  bool deleted = false;

  Product(this.name);

  void buy(bool buy) {
    bought = buy;
    print('Bought $name');
  }

  void delete() {
    deleted = true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _itemsToBuy = [
    Product("Orzeszki"),
    Product("Woda"),
  ];

  void _addItems() {
    print('Adding new product.');
    setState(() {
      _itemsToBuy.add(Product("New product"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _buildListContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItems,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListContent() {
    if (_itemsToBuy.isEmpty) {
      return const Text('Add items to the list!');
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      itemCount: _itemsToBuy.length,
      itemBuilder: (ctx, idx) => _renderProduct(_itemsToBuy[idx]),
    );
  }

  Widget _renderProduct(Product product) {
    return CheckboxListTile(
      key: ValueKey(product.name),
      title: Text(product.name),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.lightGreen,
      value: product.bought,
      onChanged: (value) => setState(() {
        print("checkbox value: $value");
        product.buy(value ?? false);
      }),
      //leading: const Icon(Icons.circle, size: 10),
    );
  }
}
