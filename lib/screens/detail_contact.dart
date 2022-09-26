import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdev_task/blocs/cubit/cantact_bloc_cubit.dart';
import 'package:stdev_task/entities/contact_response_model.dart';
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
                    setState(() {
                      contactCubit.contactResponse!.data!.remove(args);
                      Navigator.of(context).pushReplacementNamed("/");
                    });
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
                  child: const Icon(Icons.call),
                  backgroundColor: Colors.green,
                  mini: true,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await canLaunch("sms: " + args.phone);

                    await launch("sms: " + args.phone);
                  },
                  child: const Icon(Icons.message),
                  backgroundColor: Colors.amber,
                  mini: true,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await canLaunch("mailto: " + args.phone);

                    await launch("mailto: " + args.phone);
                  },
                  child: const Icon(Icons.email),
                  backgroundColor: Colors.blue,
                  mini: true,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.share),
                  backgroundColor: Colors.orange,
                  mini: true,
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
}
