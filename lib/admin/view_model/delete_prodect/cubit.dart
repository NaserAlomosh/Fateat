import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/admin/view_model/delete_prodect/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProdectCubit extends Cubit<DeleteProdectStates> {
  late DocumentReference documentReference;

  DeleteProdectCubit() : super(DeleteProdectInitState());

  Future deleteProdect({String? tybe, String? idProdect}) async {
    emit(DeleteProdectLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection(tybe!)
          .doc(idProdect)
          .delete()
          .then((value) {
        emit(DeleteProdectSuccessState());
      });
    } catch (e) {
      return false;
    }
  }
}
