import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/screens/widget/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late CantactBlocCubit contactCubit;

  @override
  void initState() {
    contactCubit = BlocProvider.of<CantactBlocCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return BlocConsumer<CantactBlocCubit, CantactBlocState>(
      listener: (context, state) {
        if (state is CantactBloceRemoved) {
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
        if (current is CantactBloceRemoved) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is CantactBloceRemoving) {
          return const LoadingWidget();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Contact",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
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
              actions: [
                const CircleAvatar(
                  radius: 15,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                )
              ],
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        // backgroundImage: (args.image != null) ? FileImage(args.image!) : null,
                      ),
                      const SizedBox(width: 60),
                      IconButton(
                        onPressed: () {
                          contactCubit.deleteContact(args.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("editpage", arguments: args);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "${args.firstName} ${args.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      args.phone,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          await canLaunch("tel:" + args.phone);

                          await launch("tel:" + args.phone);
                        },
                        backgroundColor: Colors.green,
                        mini: true,
                        child: const Icon(Icons.call),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await canLaunch("sms: " + args.phone);

                          await launch("sms: " + args.phone);
                        },
                        backgroundColor: Colors.amber,
                        mini: true,
                        child: const Icon(Icons.message),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await canLaunch("mailto: " + args.phone);

                          await launch("mailto: " + args.phone);
                        },
                        backgroundColor: Colors.blue,
                        mini: true,
                        child: const Icon(Icons.email),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.orange,
                        mini: true,
                        child: const Icon(Icons.share),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
