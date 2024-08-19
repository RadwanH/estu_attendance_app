import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final UserRepository _userRepository;

  GetUserCubit(this._userRepository) : super(GetUserInitial());

  Future<void> getUserById(String userId) async {
    emit(GetUserLoading());
    try {
      final user = await _userRepository.getUserById(userId);
      emit(GetUserSuccess(user));
    } catch (e) {
      emit(GetUserFailure(e.toString()));
    }
  }
}
