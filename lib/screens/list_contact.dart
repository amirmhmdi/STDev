import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/entities/contact_model.dart';
import 'package:stdev_task/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  late CantactBlocCubit contactCubit;

  @override
  void initState() {
    contactCubit = BlocProvider.of<CantactBlocCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("addcontactpage");
        },
      ),
      appBar: AppBar(
        title: const Text("Contact"),
        leading: null,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (isDark == true) {
                  isDark = false;
                } else {
                  isDark = true;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: (contactCubit.contactList.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/open-cardboard-box.png", height: 200),
                    const SizedBox(height: 20),
                    const Text(
                      "You have not contacts yet",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: contactCubit.contactList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed("detailpage", arguments: contactCubit.contactList[i]);
                      },
                      leading: CircleAvatar(
                        radius: 26,
                        // backgroundImage: (contactCubit.contactList[i].image != null) ? FileImage(contactCubit.contactList[i].image!) : null,
                      ),
                      title: Text("${contactCubit.contactList[i].firstName} ${contactCubit.contactList[i].lastName}"),
                      subtitle: Text(contactCubit.contactList[i].phone ?? ""),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.green, size: 33),
                        onPressed: () async {
                          String url = "tel:${contactCubit.contactList[i].phone}";

                          await canLaunch(url);

                          await launch(url);
                        },
                      ),
                    );
                  },
                )),
    );
  }
}
