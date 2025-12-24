import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/arrest/arrest_form/arrest_form_req.dart';
import 'package:wts_bloc/data/models/arrest/arrest_form/arrest_form_step_one.dart';
import 'package:wts_bloc/data/repo/repo.dart';

import '../../data/models/arrest/arrest_form/arrest_form_step_four.dart';
import '../../data/models/arrest/arrest_form/arrest_form_step_three.dart';
import '../../data/models/arrest/arrest_form/arrest_form_step_two.dart';
import '../../data/models/arrest/arrest_log_detail_model_res.dart';
import '../../data/models/arrest/arrest_pagination_res.dart';
import '../../main.dart';

part 'arrest_event.dart';
part 'arrest_state.dart';

class ArrestBloc extends Bloc<ArrestEvent, ArrestState> {
  ArrestBloc() : super(const ArrestState()) {
    on<PostArrestFormEvent>(_onPostArrestForm);
    on<PutArrestFormEvent>(_onPutArrestForm);
    on<UpdateArrestFormEvent>(_onUpdateArrestForm);
    on<ClearFormEvent>(_onClearForm);
    on<StepOneFormEvent>(_onStepOne);
    on<StepTwoFormEvent>(_onStepTwo);
    on<StepThreeFormEvent>(_onStepThree);
    on<StepFourFormEvent>(_onStepFour);
    on<ClearFomrArrestEvent>(_onClearAllForms);
    on<GetArrestLogDetail>(_onGetArrestLogDetail);
  }

  ArrestFormReq _buildPayload() {
    final one = state.arrestFromOne!;
    final two = state.arrestFromTwo!;
    final three = state.arrestFromThree!;
    final four = state.arrestFromFour!;

    return ArrestFormReq(
      tdid: one.tdid != null ? int.tryParse(one.tdid!) : null,
      recordNo: one.recordNo ?? '',
      recordLocation: one.recordLocation ?? '',
      recordDate: one.recordDate ?? '',
      recordTime: one.recordTime ?? '',
      witnessFullname: one.witnessFullname ?? '',
      witnessRace: one.witnessRace ?? '',
      witnessNationality: one.witnessNationality ?? '',
      witnessOcupation: one.witnessOcupation ?? '',
      addressNo: one.addressNo ?? '',
      addressMoo: one.addressMoo ?? '',
      addressRoad: one.addressRoad ?? '',
      addressSoi: one.addressSoi ?? '',
      subDistrict: one.subDistrict,
      district: one.district,
      province: one.province,
      phoneNumber: one.phoneNumber ?? '',
      employerFullname: two.employerFullname ?? '',
      truckBrand: two.truckBrand ?? '',
      vehicleRegistrationPlate: two.vehicleRegistrationPlate ?? '',
      vehicleType: two.vehicleType ?? '',
      vehicleAxle: two.vehicleAxle ?? '',
      vehicleRubber: two.vehicleRubber ?? '',
      vehicleTowType: two.vehicleTowType,
      towVehicleRegistrationPlateTail:
          two.towVehicleRegistrationPlateTail ?? '',
      towType: two.towType ?? '',
      towAxle: two.towAxle ?? '',
      towRubber: two.towRubber ?? '',
      distanceKingpin: two.distanceKingpin ?? '',
      truckCarrierType: two.truckCarrierType,
      ruralRoadNumber: two.ruralRoadNumber ?? '',
      sourceProvince: two.sourceProvince,
      destinationProvince: two.destinationProvince,
      weightStationType: two.weightStationType,
      explain: two.explain ?? '',
      truckTotalWeight: three.truckTotalWeight ?? '',
      legalWeight: three.legalWeight ?? '',
      overWeight: three.overWeight ?? '',
      annoucementNo: three.annoucementNo ?? '',
      truckRegistrationPlate: three.truckRegistrationPlate ?? '',
      truckRegistrationPlateCopy: three.truckRegistrationPlateCopy ?? '',
      truckLicenseType: three.truckLicenseType ?? '',
      slipWeightFromCompany: three.slipWeightFromCompany ?? '',
      slipWeightFromWeightUnit: three.slipWeightFromWeightUnit ?? '',
      localeRuralRoadNo: four.localeRuralRoadNo ?? '',
      localeKm: four.localeKm ?? '',
      localeSubDistrict: four.localeSubDistrict,
      localeDistrict: four.localeDistrict,
      localeProvince: four.localeProvince,
      localeDate: four.localeDate ?? '',
      localeTime: four.localeTime ?? '',
      confesstion: four.confesstion,
      confesstionOther: four.confesstionOther ?? '',
      evidence: four.evidence ?? 0,
      torture: four.torture ?? 0,
      tellLaw: four.tellLaw ?? 0,
      tellLawEmail: four.tellLawEmail ?? '',
      tellLawDate: four.tellLawDate ?? '',
      tellLawTime: four.tellLawTime ?? '',
      tellLawProsecutor: four.tellLawProsecutor ?? 0,
      tellLawProsecutorEmail: four.tellLawProsecutorEmail ?? '',
      tellLawProsecutorDate: four.tellLawProsecutorDate ?? '',
      tellLawProsecutorTime: four.tellLawProsecutorTime ?? '',
      provincialAdmin: four.provincialAdmin ?? 0,
      isNotRecord: four.isNotRecord ?? '',
      policeStation: four.policeStation ?? '',
      employerOwner: four.employerOwner ?? '',
      truckOwner: four.truckOwner ?? '',
      factoryData: four.factoryData ?? '',
    );
  }

  Future<void> _submitArrestForm(
    Emitter<ArrestState> emit,
    Future<dynamic> Function(String body) apiCall, {
    String? arrestId,
  }) async {
    try {
      emit(state.copyWith(arrestFormStatus: ArrestFormStatus.loading));

      final payload = _buildPayload();
      final body = json.encode(payload);
      final response = await apiCall(body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final arrestFormPostId = response.data['data']['id'] as String;
        emit(state.copyWith(
          arrestFormPostId: arrestFormPostId,
          arrestFormStatus: ArrestFormStatus.success,
        ));
      } else {
        emit(state.copyWith(
          arrestFormStatus: ArrestFormStatus.error,
          arrestError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e, stackTrace) {
      logger.e('Submit arrest form error', error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        arrestFormStatus: ArrestFormStatus.error,
        arrestError: e.toString(),
      ));
    }
  }

  Future<void> _onPostArrestForm(
    PostArrestFormEvent event,
    Emitter<ArrestState> emit,
  ) async {
    await _submitArrestForm(
      emit,
      (body) => arrestRepo.postArrestLogs(body),
    );
  }

  Future<void> _onPutArrestForm(
    PutArrestFormEvent event,
    Emitter<ArrestState> emit,
  ) async {
    final arrestId = state.arrestLogDetail?.id.toString();
    if (arrestId == null) {
      emit(state.copyWith(
        arrestFormStatus: ArrestFormStatus.error,
        arrestError: 'Arrest ID not found',
      ));
      return;
    }

    await _submitArrestForm(
      emit,
      (body) => arrestRepo.putArrestLogs(arrestId, body),
      arrestId: arrestId,
    );
  }

  Future<void> _onUpdateArrestForm(
    UpdateArrestFormEvent event,
    Emitter<ArrestState> emit,
  ) async {
    try {
      emit(state.copyWith(arrestFormStatus: ArrestFormStatus.loading));

      final body = json.encode(event.payload.toJson());
      final response = await arrestRepo.putArrestLogs(event.tdId, body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.success));
      } else {
        emit(state.copyWith(
          arrestFormStatus: ArrestFormStatus.error,
          arrestError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e, stackTrace) {
      logger.e('Update arrest form error', error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        arrestFormStatus: ArrestFormStatus.error,
        arrestError: e.toString(),
      ));
    }
  }

  void _onClearForm(ClearFormEvent event, Emitter<ArrestState> emit) {
    emit(state.copyWith(arrestForm: ArrestFormReq.empty()));
  }

  void _onStepOne(StepOneFormEvent event, Emitter<ArrestState> emit) {
    logger.d('Step 1: ${event.payload.toJson()}');
    emit(state.copyWith(arrestFromOne: event.payload));
  }

  void _onStepTwo(StepTwoFormEvent event, Emitter<ArrestState> emit) {
    logger.d('Step 2: ${event.payload.toJson()}');
    emit(state.copyWith(arrestFromTwo: event.payload));
  }

  void _onStepThree(StepThreeFormEvent event, Emitter<ArrestState> emit) {
    logger.d('Step 3: ${event.payload.toJson()}');
    emit(state.copyWith(arrestFromThree: event.payload));
  }

  void _onStepFour(StepFourFormEvent event, Emitter<ArrestState> emit) {
    logger.d('Step 4: ${event.payload.toJson()}');
    emit(state.copyWith(arrestFromFour: event.payload));
  }

  void _onClearAllForms(
    ClearFomrArrestEvent event,
    Emitter<ArrestState> emit,
  ) {
    emit(state.copyWith(
      arrestFormStatus: ArrestFormStatus.initial,
      arrestError: '',
      arrestFromOne: ArrestFormStepOneReq.empty(),
      arrestFromTwo: ArrestFormStepTwoReq.empty(),
      arrestFromThree: ArrestFormStepThreeReq.empty(),
      arrestFromFour: ArrestFormStepFourReq.empty(),
      arrestLogDetailStatus: ArrestLogDetailStatus.initial,
      arrestLogDetailError: '',
      arrestLogDetail: ArrestLogDetailModelRes.empty(),
    ));
  }

  Future<void> _onGetArrestLogDetail(
    GetArrestLogDetail event,
    Emitter<ArrestState> emit,
  ) async {
    try {
      emit(
          state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.loading));

      final response = await arrestRepo.getArrestLogsShow(event.arrestId);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = ArrestLogDetailModelRes.fromJson(response.data['data']);
        emit(state.copyWith(
          arrestLogDetail: result,
          arrestLogDetailStatus: ArrestLogDetailStatus.success,
        ));
      } else {
        emit(state.copyWith(
          arrestLogDetailStatus: ArrestLogDetailStatus.error,
          arrestLogDetailError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e, stackTrace) {
      logger.e('Get arrest detail error', error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        arrestLogDetailStatus: ArrestLogDetailStatus.error,
        arrestLogDetailError: e.toString(),
      ));
    }
  }
}
