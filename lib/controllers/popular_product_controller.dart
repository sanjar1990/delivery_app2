import 'package:flutter/material.dart';
import 'package:foo_delivery/controllers/cart_controller.dart';
import 'package:foo_delivery/data/repository/popular_product_repo.dart';
import 'package:foo_delivery/models/product_models.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
    final PopularProductRepo popularProductRepo;
    PopularProductController({required this.popularProductRepo});
    late CartController _cart;
    List<ProductModel>_popularProductList=[];
    List<ProductModel> get popularProductList =>_popularProductList;
    bool _isLoaded=false;
    bool get isLoaded=>_isLoaded;
    int _quantity=0;
    int get quantity=>_quantity;
    int _inCartItems=0;
    int get inCartItem=>_inCartItems+_quantity;
    Future<void> getPopularProductList()async{
      Response response=await popularProductRepo.getPopularProductList();
        if(response.statusCode==200){
            _popularProductList=[];
            _popularProductList.addAll(Product.fromJson(response.body).products);
            _isLoaded=true;
      update();
        }else{

        }
    }
    void setQuantity(bool isIncrement){
      if(isIncrement){
        _quantity=checkQuantity(_quantity+1);
      }else{
        
        _quantity=checkQuantity(_quantity-1);
      }
      update();
    }
    int checkQuantity(int quantity){
      if((_inCartItems+quantity)<0){
        Get.snackbar('Item count', 'You can\'t reduce more!',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white);
        if(_inCartItems>0){
          _quantity=-_inCartItems;
          return _quantity;
        }
      }if((_inCartItems+quantity)>20){
        Get.snackbar('Item count', 'You can\'t order more!',
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white,);
        return 20;
      }else{
        return quantity;
      }
    }

    void initProduct(ProductModel product,CartController cartController){
    _cart=cartController;
      _quantity=0;
      _inCartItems=0;
      var exist=false;
      exist=_cart.existInCart(product);
      if(exist){
        _inCartItems=_cart.getQuantity(product);
      }
    }

    void addItem(ProductModel product){
      // if(_quantity>0){
        _cart.addItem(product, _quantity);
        _quantity=0;
        _inCartItems=_cart.getQuantity(product);
        _cart.item.forEach((key, value) {
          print('id: ${key} value: ${value.quantity}');
        });
        Get.snackbar('Item count', 'Item add to cart!',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,);
        // _inCartItems=0;
        update();
    }
    int get totalItems =>_cart.totalItems;
    List<CartModel>get getItems=>_cart.getItems;
}