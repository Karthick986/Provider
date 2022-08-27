import 'package:demo_test/item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ItemModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Provider'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  final TextEditingController _etText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ItemModel cart = Provider.of<ItemModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cart.addItem(_etText.text);
            _etText.clear();
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _etText,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add item"),
                ),
              ),
              Expanded(
                child: Consumer<ItemModel>(
                  builder: (context, cart, child) => ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cart.items[index].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cart.deleteItem(index);
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: cart.itemLength,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
