import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/repo/repo.dart';

import '../../data/models/profiles/user_profile_res.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(profileStatus: ProfileStatus.loading));
        final response = await profileRepo.getProfile();
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final result = UserProfileRes.fromJson(response.data['data']);
          emit(state.copyWith(profileStatus: ProfileStatus.success, profile: result));
          return;
        }
        emit(state.copyWith(profileStatus: ProfileStatus.error, profileError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(profileStatus: ProfileStatus.error, profileError: e.toString()));
        return;
      }
    });

    on<ClearProfileEvent>((event, emit) async {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));

      emit(state.copyWith(profileStatus: ProfileStatus.initial, profile: UserProfileRes.empty()));
    });
  }
}
