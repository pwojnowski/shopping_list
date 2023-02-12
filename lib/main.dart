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

  void buy(bool buy) {
    bought = buy;
    print('Bought $name');
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      itemCount: _itemsToBuy.length,
      itemBuilder: (ctx, idx) => _renderProduct(_itemsToBuy[idx], idx),
      separatorBuilder: (ctx, idx) => const Divider(),
    );
  }

  Widget _renderProduct(Product product, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          _itemsToBuy.removeAt(index);
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
        print("checkbox value: $value");
        product.buy(value ?? false);
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
