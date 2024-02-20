import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foo_delivery/data/repository/cart_repo.dart';
import 'package:foo_delivery/models/product_models.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
   CartController({required this.cartRepo});
   Map<int, CartModel> _items={};
   Map<int, CartModel> get item=>_items;
   List<CartModel>storageItem=[];
   void addItem(ProductModel product, int quantity){
     var totalQuantity=0;
     if(_items.containsKey(product.id)){
            _items.update(product.id!, (value){
              totalQuantity=value.quantity!+quantity;
              return CartModel(
                  id:value.id,
                  name: value.name,
                  price:value.price,
                  img:value.img,
                  quantity:value.quantity!+quantity,
                  isExist:true,
                  time:DateTime.now().toString(),
                  product: product
              );
            });
            if(totalQuantity<=0){
              _items.remove(product.id);
            }
          }else{
            if(quantity>0){
              _items.putIfAbsent(product.id!, (){
                return CartModel(
                    id:product.id,
                    name: product.name, price:product.price,
                    img:product.img,
                    quantity:quantity,
                    isExist:true,
                    time:DateTime.now().toString(),
                    product: product,
                );
              });
            }else{
              Get.snackbar('No item', 'You should add item!',
                      backgroundColor: AppColors.mainColor,
                      colorText: Colors.white,);
            }

          }
     cartRepo.addToCardList(getItems);
     update();
   }
   bool existInCart(ProductModel product){
     if(_items.containsKey(product.id)) return true;
     return false;
   }
  int getQuantity(ProductModel product){
     var quantity=0;
     if(_items.containsKey(product.id)){
       _items.forEach((key, value) {
         if(key==product.id){
           quantity=value.quantity!;
         }
       });
     }
     return quantity;
  }
  int get totalItems{
     var totalQuantity=0;
     _items.forEach((key, value) {
       totalQuantity+=value.quantity!;
     });
     return totalQuantity;
  }

  List<CartModel> get getItems{
     return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount{
     var total=0;

      getItems.forEach((e) {
       total+=e.price!*e.quantity!;
     });
     return total;
  }

  List<CartModel> getCartData(){
  setCart=cartRepo.getCartList();
     return storageItem;
  }
  set setCart(List<CartModel> items){
     storageItem=items;
     for( int i=0; i<storageItem.length; i++){
       _items.putIfAbsent(storageItem[i].product!.id!, () => storageItem[i]);
     }
  }
  void addToHistory(){
     cartRepo.addToCartHistoryList();
      clear();
  }
  void clear(){
     _items={};
     update();
  }
  List<CartModel>getCartHistoryList(){
     return cartRepo.getCartHistoryList();
  }
  set setItems(Map<int, CartModel> setItems){
     _items={};
     _items=setItems;
  }

  void addToCartList(){
     cartRepo.addToCardList(getItems);
     update();
  }
  void clearCartHistory(){
     cartRepo.clearCartHistory();
  update();
   }

}