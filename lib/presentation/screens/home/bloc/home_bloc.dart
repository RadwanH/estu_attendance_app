import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeNavigateToCourseGridEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        // Get courses
        emit(HomeNavigateToCourseGridState());
        print('Navigate to course grid clicked!!!!!!');
      } catch (e) {
        emit(HomeFailure(e.toString()));
      }
    });
  }
}
