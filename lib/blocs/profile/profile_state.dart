part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus? profileStatus;
  final UserProfileRes? profile;
  final String? profileError;

  const ProfileState({
    this.profileStatus = ProfileStatus.initial,
    this.profile,
    this.profileError = '',
  });

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    UserProfileRes? profile,
    String? profileError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      profile: profile ?? this.profile,
      profileError: profileError ?? this.profileError,
    );
  }

  @override
  List<Object?> get props => [
        profileStatus,
        profile,
        profileError,
      ];
}
