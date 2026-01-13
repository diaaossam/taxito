import 'package:taxito/features/captain/auth/domain/usecases/get_user_data_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/common/models/user_model.dart';
import 'package:taxito/features/common/models/user_model_helper.dart';

part 'user_event.dart';

part 'user_state.dart';

@Injectable()
class UserBloc extends Cubit<UserState> {
  final GetUserDataUseCase getUserDataUseCase;

  UserBloc(this.getUserDataUseCase) : super(UserInitial());

  Future<UserModel?> getUserData({required num? userId}) async {
    UserModel? userModel;
    final response = await getUserDataUseCase();
    response.fold((l) {
      userModel = UserDataService().getUserData()!;
    }, (r) {
      userModel = r.data;
    });

    emit(GetUserSuccess(userModel: userModel!));
    return userModel;
  }
}
