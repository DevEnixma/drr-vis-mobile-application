part of 'establish_bloc.dart';

sealed class EstablishEvent extends Equatable {
  const EstablishEvent();

  @override
  List<Object> get props => [];
}

class MobileMasterFetchEvent extends EstablishEvent {
  final String start_date;
  final String end_date;
  final int page;
  final int pageSize;

  const MobileMasterFetchEvent(
      {required this.start_date,
      required this.end_date,
      required this.page,
      required this.pageSize});
}

class MobileMasterDepartmentFetchEvent extends EstablishEvent {
  final String tid;

  const MobileMasterDepartmentFetchEvent({required this.tid});
}

class MobileCarFetchEvent extends EstablishEvent {
  final EstablishWeightCarRes payload;
  const MobileCarFetchEvent(this.payload);
}

class CreateUnitWeight extends EstablishEvent {
  final EstablishAddUnitReq payload;

  const CreateUnitWeight(this.payload);
}

class ResetCreateUnitWeight extends EstablishEvent {
  const ResetCreateUnitWeight();
}

class GetCarDetailEvent extends EstablishEvent {
  final String paylaod;

  const GetCarDetailEvent(this.paylaod);
}

class GetCarDetailImageEvent extends EstablishEvent {
  final String tId;
  final String tdId;

  const GetCarDetailImageEvent(this.tId, this.tdId);
}

class PostJoinWeightUnit extends EstablishEvent {
  final JoinWeightUnitReq payload;
  final String weightUnitJoinScreen;

  const PostJoinWeightUnit(this.payload, this.weightUnitJoinScreen);
}

class DeleteJoinWeightUnit extends EstablishEvent {
  final String tId;
  final String username;

  const DeleteJoinWeightUnit(this.tId, this.username);
}

class GetWeightUnitsIsJoinEvent extends EstablishEvent {
  final String start_date;
  final String end_date;
  final int page;
  final int pageSize;

  const GetWeightUnitsIsJoinEvent(
      {required this.start_date,
      required this.end_date,
      required this.page,
      required this.pageSize});
}

class ClearPostJoinWeightUnit extends EstablishEvent {
  const ClearPostJoinWeightUnit();
}

class DeleteWeightUnitLeaveEvent extends EstablishEvent {
  final String tId;
  final String username;
  const DeleteWeightUnitLeaveEvent(this.tId, this.username);
}

class PostWeightUnitCloseEvent extends EstablishEvent {
  final String tId;
  const PostWeightUnitCloseEvent(this.tId);
}
