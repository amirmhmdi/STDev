import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/entities/contact_data_model.dart';
import 'package:stdev_task/entities/contact_response_model.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  GlobalKey<FormState> addcontactkey = GlobalKey<FormState>();

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? notes;

  late CantactBlocCubit contactCubit;

  @override
  void initState() {
    contactCubit = BlocProvider.of<CantactBlocCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CantactBlocCubit, CantactBlocState>(
      listener: (context, state) {
        if (state is CantactBlocAdded) {
          Navigator.of(context).pop();
        } else if (state is CantactBlocServerError) {
          showToast(
            state.errorMessage,
            duration: const Duration(milliseconds: 3500),
            position: ToastPosition.top,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 3.0,
            textStyle: const TextStyle(fontSize: 30.0),
          );
        }
      },
      buildWhen: (previous, current) {
        if (current is CantactBlocAdded) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is CantactBlocAdding) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              title: const Text(
                "Add",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (addcontactkey.currentState!.validate()) {
                          addcontactkey.currentState!.save();
                          ContactData contactData = ContactData(
                            firstName: firstname,
                            lastName: lastname,
                            phone: phone,
                            email: email,
                            notes: notes,
                            // image: _image,
                          );
                          contactCubit.addContact(contactData);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.black,
                    ))
              ],
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey.shade400,
                          backgroundImage: (_image != null) ? FileImage(_image!) : null,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              (_image != null)
                                  ? Container()
                                  : const Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              (_image != null)
                                  ? Container()
                                  : Align(
                                      alignment: Alignment(0.9, 0.8),
                                      child: FloatingActionButton(
                                        child: Icon(Icons.add),
                                        onPressed: () async {
                                          XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
                                          String path = xfile!.path;

                                          setState(() {
                                            _image = File(path);
                                          });
                                        },
                                        mini: true,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          child: Form(
                            key: addcontactkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _firstname,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter firstname here";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    firstname = val;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "First Name",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _lastname,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter lastname here";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    lastname = val;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Last Name",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _phone,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter phone number here";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    phone = val;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: "Phone Number",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _email,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter email here";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    email = val;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _notes,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter note here";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    notes = val;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "note",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
