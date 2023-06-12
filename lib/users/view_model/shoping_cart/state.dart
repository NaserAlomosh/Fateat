part of 'cubit.dart';

@immutable
abstract class ShopCartState {}

class ShopCartInitial extends ShopCartState {}

class ShopCartSuccess extends ShopCartState {}

class ShopCartSuccessSendOrder extends ShopCartState {}

class ShopCartLoading extends ShopCartState {}

class ShopCartErrorLocation extends ShopCartState {}

class ShopCartRequstLocation extends ShopCartState {}

class ShopCartError extends ShopCartState {}
