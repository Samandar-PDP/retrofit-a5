import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:retrofit_practice/product.dart';
import 'package:retrofit_practice/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Product> _productList = [];
  final _repo = Repository();

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  _fetch() async {
    _productList.addAll(await _repo.getProducts());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Mayiz")
      ),
      body: _productList.isEmpty ? const Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12
          ),
          itemCount: _productList.length,
          itemBuilder: (context, index) {
            final product = _productList[index];
            return Card(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: product.image ?? "",
                        placeholder: (context, url) => const SizedBox(height: 55,child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const Gap(5),
                    Text(product.title ?? "")
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
