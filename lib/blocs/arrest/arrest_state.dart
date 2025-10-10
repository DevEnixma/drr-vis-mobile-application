part of 'arrest_bloc.dart';

enum ArrestStatus {
  initial,
  loading,
  success,
  error,
}

enum ArrestFormStatus {
  initial,
  loading,
  success,
  error,
}

enum ArrestLogDetailStatus {
  initial,
  loading,
  success,
  error,
}

class ArrestState extends Equatable {
  final ArrestStatus arrestStatus;
  final String arrestError;
  final ArrestPaginationRes? arrestPagination;
  final bool? loadMore;
  final int? total;

  final ArrestFormStatus? arrestFormStatus;
  final ArrestFormReq? arrestForm;
  final String arrestFormError;
  final String arrestFormPostId;

  final ArrestFormStepOneReq? arrestFromOne;
  final ArrestFormStepTwoReq? arrestFromTwo;
  final ArrestFormStepThreeReq? arrestFromThree;
  final ArrestFormStepFourReq? arrestFromFour;

  final ArrestLogDetailStatus? arrestLogDetailStatus;
  final ArrestLogDetailModelRes? arrestLogDetail;
  final String? arrestLogDetailError;

  const ArrestState({
    this.arrestStatus = ArrestStatus.initial,
    this.arrestError = '',
    this.arrestPagination,
    this.loadMore = false,
    this.total = 0,
    this.arrestFormStatus = ArrestFormStatus.initial,
    this.arrestFormError = '',
    this.arrestFormPostId = '',
    this.arrestForm,
    this.arrestFromOne,
    this.arrestFromTwo,
    this.arrestFromThree,
    this.arrestFromFour,
    this.arrestLogDetailStatus = ArrestLogDetailStatus.initial,
    this.arrestLogDetail,
    this.arrestLogDetailError = '',
  });

  ArrestState copyWith({
    ArrestStatus? assestStatus,
    String? arrestError,
    ArrestPaginationRes? arrestPagination,
    bool? loadMore,
    int? total,
    ArrestFormStatus? arrestFormStatus,
    String? arrestFormError,
    ArrestFormReq? arrestForm,
    String? arrestFormPostId,
    ArrestFormStepOneReq? arrestFromOne,
    ArrestFormStepTwoReq? arrestFromTwo,
    ArrestFormStepThreeReq? arrestFromThree,
    ArrestFormStepFourReq? arrestFromFour,
    ArrestLogDetailStatus? arrestLogDetailStatus,
    ArrestLogDetailModelRes? arrestLogDetail,
    String? arrestLogDetailError,
  }) {
    return ArrestState(
      arrestStatus: assestStatus ?? this.arrestStatus,
      arrestError: arrestError ?? this.arrestError,
      arrestPagination: arrestPagination ?? this.arrestPagination,
      loadMore: loadMore ?? this.loadMore,
      total: total ?? this.total,
      arrestFormStatus: arrestFormStatus ?? this.arrestFormStatus,
      arrestFormError: arrestFormError ?? this.arrestFormError,
      arrestForm: arrestForm ?? this.arrestForm,
      arrestFormPostId: arrestFormPostId ?? this.arrestFormPostId,
      arrestFromOne: arrestFromOne ?? this.arrestFromOne,
      arrestFromTwo: arrestFromTwo ?? this.arrestFromTwo,
      arrestFromThree: arrestFromThree ?? this.arrestFromThree,
      arrestFromFour: arrestFromFour ?? this.arrestFromFour,
      arrestLogDetailStatus: arrestLogDetailStatus ?? this.arrestLogDetailStatus,
      arrestLogDetail: arrestLogDetail ?? this.arrestLogDetail,
      arrestLogDetailError: arrestLogDetailError ?? this.arrestLogDetailError,
    );
  }

  @override
  List<Object?> get props => [
        arrestStatus,
        arrestError,
        arrestPagination,
        loadMore,
        total,
        arrestFormStatus,
        arrestFormError,
        arrestForm,
        arrestFormPostId,
        arrestFromOne,
        arrestFromTwo,
        arrestFromThree,
        arrestFromFour,
        arrestLogDetailStatus,
        arrestLogDetail,
        arrestLogDetailError,
      ];
}
