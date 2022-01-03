import 'package:counter/app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          CounterCubit cubit = CounterCubit.get(context);
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 45,
                  ),
                  RaisedButton(
                    onPressed: () {
                      cubit.decreaseNumber();
                    },
                    child: Icon(
                      Icons.remove,
                      size: 50,
                    ),
                    color: Colors.redAccent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0),
                    textColor: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      '${cubit.number}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      cubit.increaseNumber();
                    },
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                    color: Colors.blueAccent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0),
                    textColor: Colors.white,
                  ),
                  SizedBox(width: 45),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
