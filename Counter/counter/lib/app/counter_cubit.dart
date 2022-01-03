import 'package:bloc/bloc.dart';
import 'package:counter/app/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitStates());

  static CounterCubit get (BuildContext context){
    return BlocProvider.of(context);
  }

  int number = 1;

  void increaseNumber(){
    number++;
    emit(CounterIncrementNumber());
  }
  
  void decreaseNumber(){
    number--;
    emit(CounterIncrementNumber());
  }

}