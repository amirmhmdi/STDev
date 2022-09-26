import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stdev_task/entities/contact_data_model.dart';
import 'package:stdev_task/entities/contact_response_model.dart';
import 'package:stdev_task/repositories/contact_repository.dart';

part 'cantact_bloc_state.dart';

class CantactBlocCubit extends Cubit<CantactBlocState> {
  CantactBlocCubit() : super(CantactBlocInitial());
  ContactRepository contactRepository = ContactRepository();

  Contact? contactResponse;

  void fetchContact() async {
    emit(CantactBlocLoading());
    String mock =
        '[{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"},{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"},{"_id": "string","firstName": "string","lastName": "string","email": "string","notes": "string","picture": ["string"],"phone": "string"}]';
    var response = await contactRepository.loadContact();

    if (response.statusCode == 200) {
      contactResponse = Contact.fromJson(jsonDecode(response.body));
      emit(CantactBlocLoaded());
    } else {
      emit(CantactBlocLoadedError());
    }
  }

  void addContact(ContactData contact) async {
    ContactData? responseContactData;
    emit(CantactBlocAdding());
    var response = await contactRepository.addContact(contact);

    if (response.statusCode == 200) {
      responseContactData = ContactData.fromJson(jsonDecode(response.body));
      contactResponse?.data?.add(responseContactData);
      contactResponse?.count = contactResponse?.data?.length.toString();
      emit(CantactBlocAdded());
      emit(CantactBlocLoaded());
    } else {
      emit(CantactBlocServerError("Server Error"));
    }
  }

  void editContact(ContactData editedContact) async {
    emit(CantactBlocEditing());
    var response = await contactRepository.editContact(editedContact);

    if (response.statusCode == 200) {
      ContactData responseContactData = ContactData.fromJson(jsonDecode(response.body));
      contactResponse?.data?.removeWhere((element) => element.id == editedContact.id);
      // TODO : it must return image url too, but it dosent return url of contact image
      // contactResponse?.data?.add(responseContactData);

      //quick fix use this^
      contactResponse?.data?.add(editedContact);

      emit(CantactBlocEdited());
      emit(CantactBlocLoaded());
    } else if (response.statusCode == 400) {
      emit(CantactBlocServerError("Validation error"));
    } else if (response.statusCode == 404) {
      emit(CantactBlocServerError("Document not found"));
    } else {
      emit(CantactBlocServerError("Server Error"));
    }
  }

  void deleteContact(String deletedContactId) async {
    emit(CantactBloceRemoving());
    var response = await contactRepository.deleteContact(deletedContactId);

    if (response.statusCode == 204) {
      contactResponse?.data?.removeWhere((element) => element.id == deletedContactId);
      emit(CantactBloceRemoved());
      emit(CantactBlocLoaded());
    } else {
      emit(CantactBlocServerError("Document not found"));
    }
  }
}
