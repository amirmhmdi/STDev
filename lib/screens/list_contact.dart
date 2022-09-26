import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/main.dart';
import 'package:stdev_task/utils/choose_color.dart';
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
    contactCubit = BlocProvider.of<CantactBlocCubit>(context)..fetchContact();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSwitch(
                value: isDark,
                activeColor: Colors.blueGrey,
                trackColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                  });
                },
              ),
            ),
          ],
        ),
        body: BlocConsumer<CantactBlocCubit, CantactBlocState>(
          listener: (context, state) {
            if (state is CantactBlocServerError) {
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
          builder: (context, state) {
            if (state is CantactBlocLoaded) {
              return Container(
                  alignment: Alignment.center,
                  child: (contactCubit.contactResponse == null && contactCubit.contactResponse!.data!.isEmpty)
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
                          itemCount: contactCubit.contactResponse!.data!.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed("detailpage", arguments: contactCubit.contactResponse!.data![i]);
                              },
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundColor: chooseColor(contactCubit.contactResponse!.data![i].lastName ?? "  "),
                                foregroundImage: NetworkImage(contactCubit.contactResponse?.data?[i].picture?.first ?? ""),
                                child: Text(
                                  contactCubit.contactResponse!.data![i].firstName!.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text("${contactCubit.contactResponse!.data![i].firstName} ${contactCubit.contactResponse!.data![i].lastName}"),
                              subtitle: Text(contactCubit.contactResponse!.data![i].phone ?? ""),
                              trailing: IconButton(
                                icon: const Icon(Icons.call, color: Colors.green, size: 33),
                                onPressed: () async {
                                  String url = "tel:${contactCubit.contactResponse!.data![i].phone}";

                                  await canLaunch(url);

                                  await launch(url);
                                },
                              ),
                            );
                          },
                        ));
            }
            if (state is CantactBlocLoadedError) {
              return Center(
                child: ElevatedButton(
                  child: const Text("Try again"),
                  onPressed: () {
                    contactCubit.fetchContact();
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
