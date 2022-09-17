import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/entities/contact_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  GlobalKey<FormState> editcontactkey = GlobalKey<FormState>();

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  String? firstname;
  String? lastname;
  String? phone;
  String? email;

  late CantactBlocCubit contactCubit;

  @override
  void initState() {
    contactCubit = BlocProvider.of<CantactBlocCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    _firstname.text = args.firstName;
    _lastname.text = args.lastName;
    _phone.text = args.phone;
    _email.text = args.email;
    _note.text = args.notes;
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
                  if (editcontactkey.currentState!.validate()) {
                    editcontactkey.currentState!.save();
                    Contact cont = Contact(
                      firstName: firstname,
                      lastName: lastname,
                      phone: phone,
                      email: email,
                      // image: _image,
                    );

                    int i = contactCubit.contactList.indexOf(args);
                    contactCubit.contactList[i] = cont;
                    setState(() {
                      Navigator.of(context).pushReplacementNamed("/");
                    });
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
                      key: editcontactkey,
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
                            controller: _note,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter note here";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val;
                            },
                            decoration: const InputDecoration(
                              hintText: "Note",
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
    ;
  }
}
