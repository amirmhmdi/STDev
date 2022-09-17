import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stdev_task/entities/contact_model.dart';

part 'cantact_bloc_state.dart';

class CantactBlocCubit extends Cubit<CantactBlocState> {
  CantactBlocCubit() : super(CantactBlocInitial());

  List<Contact> contactList = <Contact>[];
}
