part of 'arrest_bloc.dart';

sealed class ArrestEvent extends Equatable {
  const ArrestEvent();

  @override
  List<Object> get props => [];
}

class PostArrestFormEvent extends ArrestEvent {
  final int tdId;
  const PostArrestFormEvent(this.tdId);
}

class PutArrestFormEvent extends ArrestEvent {
  final int tdId;
  const PutArrestFormEvent(this.tdId);
}

class UpdateArrestFormEvent extends ArrestEvent {
  final String tdId;
  final ArrestFormReq payload;

  const UpdateArrestFormEvent(this.tdId, this.payload);
}

class ClearFormEvent extends ArrestEvent {
  const ClearFormEvent();
}

class StepOneFormEvent extends ArrestEvent {
  final ArrestFormStepOneReq payload;

  const StepOneFormEvent(this.payload);
}

class StepTwoFormEvent extends ArrestEvent {
  final ArrestFormStepTwoReq payload;

  const StepTwoFormEvent(this.payload);
}

class StepThreeFormEvent extends ArrestEvent {
  final ArrestFormStepThreeReq payload;

  const StepThreeFormEvent(this.payload);
}

class StepFourFormEvent extends ArrestEvent {
  final ArrestFormStepFourReq payload;

  const StepFourFormEvent(this.payload);
}

class ClearFomrArrestEvent extends ArrestEvent {
  const ClearFomrArrestEvent();
}

class GetArrestLogDetail extends ArrestEvent {
  final String arrestId;
  const GetArrestLogDetail(this.arrestId);
}
