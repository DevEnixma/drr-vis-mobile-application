part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}

class ClearProfileEvent extends ProfileEvent {
  const ClearProfileEvent();
}
