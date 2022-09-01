import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_app/cubit/internet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state == InternetState.gained) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Internet Coneected'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Internet not Coneected'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state == InternetState.gained) {
            return const Center(
              child: Text('Connected!'),
            );
          } else if (state == InternetState.lost) {
            return const Center(
              child: Text('Not Connected!'),
            );
          } else {
            return const Center(
              child: Text('Loading...!'),
            );
          }
        },
      ),
    );
  }
}
