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

  void buy() {
    bought = true;
    print('Bought $name');
  }

  void delete() {
    deleted = true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> _itemsToBuy = [Product("Orzeszki")];

  void _addItems() {
    print("Not implemented yet!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: buildColumnContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItems,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildColumnContent() {
    if (_itemsToBuy.isEmpty) {
      return const Text('Add items to the list!');
    }
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      children: renderProducts(),
    );
  }

  List<Widget> renderProducts() {
    return _itemsToBuy.map((product) => renderProduct(product)).toList();
  }

  Widget renderProduct(Product product) {
    return ListTile(
      key: ValueKey(product.name),
      title: Text(product.name),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.lightGreen,
      //leading: const Icon(Icons.circle, size: 10),
      trailing: createProductButtons(product),
    );
  }

  Widget createProductButtons(Product product) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
              onPressed: () => {product.buy()},
              icon: const Icon(Icons.shopping_basket_outlined),
              label: const Text(""))
        ],
      ),
    );
  }
}
