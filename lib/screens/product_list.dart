import 'package:flutter/material.dart';

class ProductList extends StatefulWidget
  @override
  State<StatefulWidget> createState() {
    
    return _ProductListState();
      }
    
    class _ProductListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Ürün Listesi"),),body: buildProductList(),);
      }
    
      buildProductList() {
        
      }
}
