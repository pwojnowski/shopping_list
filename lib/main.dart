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
        primarySwatch: Colors.lightGreen,
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.orangeAccent,
          textColor: Colors.black,
          iconColor: Colors.white,
        ),
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

  Product(this.name);
}

class Products {
  final List<Product> _itemsToBuy = [
    Product("Orzeszki"),
    Product("Woda"),
  ];

  bool get isEmpty => _itemsToBuy.isEmpty;

  int get length => _itemsToBuy.length;

  void add(String name) {
    print('Adding new product.');
    _itemsToBuy.add(Product(name));
    _sort();
  }

  void buy(Product product, bool value) {
    product.bought = value;
    _sort();
  }

  Product getAt(int index) {
    return _itemsToBuy[index];
  }

  void removeAt(int index) {
    _itemsToBuy.removeAt(index);
    _sort();
  }

  void _sort() {
    _itemsToBuy.sort((a, b) {
      if (a.bought == b.bought) {
        return 0;
      }
      return a.bought ? 1 : -1;
    });
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final Products _products = Products();

  void _addItems() {
    setState(() {
      _products.add("New product");
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _addItems,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListContent() {
    if (_products.isEmpty) {
      return const Text('Add items to the list!');
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      itemCount: _products.length,
      itemBuilder: (ctx, idx) => _renderProduct(_products.getAt(idx), idx),
      separatorBuilder: (ctx, idx) => const Divider(),
    );
  }

  Widget _renderProduct(Product product, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          _products.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${product.name} removed!"),
          ),
        );
      },
      child: _buildTail(product),
    );
  }

  Widget _buildTail(Product product) {
    return CheckboxListTile(
      key: ValueKey(product.name),
      title: Text(product.name),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      value: product.bought,
      tileColor: _getTailColor(product),
      onChanged: (value) => setState(() {
        _products.buy(product, value ?? false);
      }),
    );
  }

  Color? _getTailColor(Product product) {
    if (product.bought) {
      return Colors.grey;
    }
    return Theme.of(context).listTileTheme.tileColor;
  }
}
