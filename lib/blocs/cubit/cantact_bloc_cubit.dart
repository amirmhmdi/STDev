import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stdev_task/entities/contact_model.dart';
import 'package:stdev_task/repositories/contact_repository.dart';

part 'cantact_bloc_state.dart';

class CantactBlocCubit extends Cubit<CantactBlocState> {
  CantactBlocCubit() : super(CantactBlocInitial());
  ContactRepository contactRepository = ContactRepository();

  List<Contact> contactList = <Contact>[];

  void fetchContact() async {
    emit(CantactBlocLoading());
    String mock =
        '[{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"},{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"},{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"}]';
    var response = await contactRepository.loadContact();

    if (response.statusCode == 200) {
      List listJson = jsonDecode(mock);
      listJson.forEach((element) {
        Contact contact = Contact.fromJson(element);
        contactList.add(contact);
      });
      emit(CantactBlocLoaded());
    } else {
      emit(CantactBlocLoadedError());
    }
  }

  void editContact(Contact editedContact) async {
    var response = await contactRepository.editContact(editedContact);

    if (response.statusCode == 200) {
      emit(CantactBlocedited());
    } else if (response.statusCode == 400) {
      emit(CantactBlocServerError("Validation error"));
    } else if (response.statusCode == 404) {
      emit(CantactBlocServerError("Document not found"));
    } else {
      emit(CantactBlocServerError("Server Error"));
    }
  }

  void deleteContact(String deletedContactId) async {
    var response = await contactRepository.deleteContact(deletedContactId);

    if (response.statusCode == 200) {
      emit(CantactBloceRemoved());
    } else {
      emit(CantactBlocServerError("Document not found"));
    }
  }
}
