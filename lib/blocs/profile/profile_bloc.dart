import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/repo/repo.dart';

import '../../data/models/profiles/user_profile_res.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetProfileEvent>(_onGetProfile);
    on<ClearProfileEvent>(_onClearProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final response = await profileRepo.getProfile();

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = UserProfileRes.fromJson(response.data['data']);

        emit(state.copyWith(
          profileStatus: ProfileStatus.success,
          profile: result,
        ));
      } else {
        emit(state.copyWith(
          profileStatus: ProfileStatus.error,
          profileError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        profileError: e.toString(),
      ));
    }
  }

  void _onClearProfile(
    ClearProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(
      profileStatus: ProfileStatus.initial,
      profile: UserProfileRes.empty(),
      profileError: '',
    ));
  }
}
