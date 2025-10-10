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
    on<PostArrestFormEvent>((event, emit) async {
      try {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.loading));
        var payload = ArrestFormReq(
          tdid: state.arrestFromOne!.tdid != null ? int.parse(state.arrestFromOne!.tdid!) : null,
          recordNo: state.arrestFromOne!.recordNo ?? '',
          recordLocation: state.arrestFromOne!.recordLocation ?? '',
          recordDate: state.arrestFromOne!.recordDate ?? '',
          recordTime: state.arrestFromOne!.recordTime ?? '',
          witnessFullname: state.arrestFromOne!.witnessFullname ?? '',
          witnessRace: state.arrestFromOne!.witnessRace ?? '',
          witnessNationality: state.arrestFromOne!.witnessNationality ?? '',
          witnessOcupation: state.arrestFromOne!.witnessOcupation ?? '',
          addressNo: state.arrestFromOne!.addressNo ?? '',
          addressMoo: state.arrestFromOne!.addressMoo ?? '',
          addressRoad: state.arrestFromOne!.addressRoad ?? '',
          addressSoi: state.arrestFromOne!.addressSoi ?? '',
          subDistrict: state.arrestFromOne!.subDistrict ?? null,
          district: state.arrestFromOne!.district ?? null,
          province: state.arrestFromOne!.province ?? null,
          phoneNumber: state.arrestFromOne!.phoneNumber ?? '',
          employerFullname: state.arrestFromTwo!.employerFullname ?? '',
          truckBrand: state.arrestFromTwo!.truckBrand ?? '',
          vehicleRegistrationPlate: state.arrestFromTwo!.vehicleRegistrationPlate ?? '',
          vehicleType: state.arrestFromTwo!.vehicleType ?? '',
          vehicleAxle: state.arrestFromTwo!.vehicleAxle ?? '',
          vehicleRubber: state.arrestFromTwo!.vehicleRubber ?? '',
          vehicleTowType: state.arrestFromTwo!.vehicleTowType ?? null,
          towVehicleRegistrationPlateTail: state.arrestFromTwo!.towVehicleRegistrationPlateTail ?? '',
          towType: state.arrestFromTwo!.towType ?? '',
          towAxle: state.arrestFromTwo!.towAxle ?? '',
          towRubber: state.arrestFromTwo!.towRubber ?? '',
          distanceKingpin: state.arrestFromTwo!.distanceKingpin ?? '',
          truckCarrierType: state.arrestFromTwo!.truckCarrierType ?? null,
          ruralRoadNumber: state.arrestFromTwo!.ruralRoadNumber ?? '',
          sourceProvince: state.arrestFromTwo!.sourceProvince ?? null,
          destinationProvince: state.arrestFromTwo!.destinationProvince ?? null,
          weightStationType: state.arrestFromTwo!.weightStationType ?? null,
          explain: state.arrestFromTwo!.explain ?? '',
          truckTotalWeight: state.arrestFromThree!.truckTotalWeight ?? '',
          legalWeight: state.arrestFromThree!.legalWeight ?? '',
          overWeight: state.arrestFromThree!.overWeight ?? '',
          annoucementNo: state.arrestFromThree!.annoucementNo ?? '',
          truckRegistrationPlate: state.arrestFromThree!.truckRegistrationPlate ?? '',
          truckRegistrationPlateCopy: state.arrestFromThree!.truckRegistrationPlateCopy ?? '',
          truckLicenseType: state.arrestFromThree!.truckLicenseType ?? '',
          slipWeightFromCompany: state.arrestFromThree!.slipWeightFromCompany ?? '',
          slipWeightFromWeightUnit: state.arrestFromThree!.slipWeightFromWeightUnit ?? '',
          localeRuralRoadNo: state.arrestFromFour!.localeRuralRoadNo ?? '',
          localeKm: state.arrestFromFour!.localeKm ?? '',
          localeSubDistrict: state.arrestFromFour!.localeSubDistrict ?? null,
          localeDistrict: state.arrestFromFour!.localeDistrict ?? null,
          localeProvince: state.arrestFromFour!.localeProvince ?? null,
          localeDate: state.arrestFromFour!.localeDate ?? '',
          localeTime: state.arrestFromFour!.localeTime ?? '',
          confesstion: state.arrestFromFour!.confesstion ?? null,
          confesstionOther: state.arrestFromFour!.confesstionOther ?? '',
          evidence: state.arrestFromFour!.evidence ?? 0,
          torture: state.arrestFromFour!.torture ?? 0,
          tellLaw: state.arrestFromFour!.tellLaw ?? 0,
          tellLawEmail: state.arrestFromFour!.tellLawEmail ?? '',
          tellLawDate: state.arrestFromFour!.tellLawDate ?? '',
          tellLawTime: state.arrestFromFour!.tellLawTime ?? '',
          tellLawProsecutor: state.arrestFromFour!.tellLawProsecutor ?? 0,
          tellLawProsecutorEmail: state.arrestFromFour!.tellLawProsecutorEmail ?? '',
          tellLawProsecutorDate: state.arrestFromFour!.tellLawProsecutorDate ?? '',
          tellLawProsecutorTime: state.arrestFromFour!.tellLawProsecutorTime ?? '',
          provincialAdmin: state.arrestFromFour!.provincialAdmin ?? 0,
          isNotRecord: state.arrestFromFour!.isNotRecord ?? '',
          policeStation: state.arrestFromFour!.policeStation ?? '',
          employerOwner: state.arrestFromFour!.employerOwner ?? '',
          truckOwner: state.arrestFromFour!.truckOwner ?? '',
          factoryData: state.arrestFromFour!.factoryData ?? '',
        );

        var body = json.encode(payload);

        final response = await arrestRepo.postArrestLogs(body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          String arrestFormPostId = response.data['data']['id'];

          emit(state.copyWith(arrestFormPostId: arrestFormPostId));

          emit(state.copyWith(arrestFormStatus: ArrestFormStatus.success));
          return;
        }

        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: e.toString()));
        return;
      }
    });

    on<PutArrestFormEvent>((event, emit) async {
      try {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.loading));

        var payload = ArrestFormReq(
          tdid: state.arrestFromOne!.tdid != null ? int.parse(state.arrestFromOne!.tdid!) : null,
          recordNo: state.arrestFromOne!.recordNo ?? '',
          recordLocation: state.arrestFromOne!.recordLocation ?? '',
          recordDate: state.arrestFromOne!.recordDate ?? '',
          recordTime: state.arrestFromOne!.recordTime ?? '',
          witnessFullname: state.arrestFromOne!.witnessFullname ?? '',
          witnessRace: state.arrestFromOne!.witnessRace ?? '',
          witnessNationality: state.arrestFromOne!.witnessNationality ?? '',
          witnessOcupation: state.arrestFromOne!.witnessOcupation ?? '',
          addressNo: state.arrestFromOne!.addressNo ?? '',
          addressMoo: state.arrestFromOne!.addressMoo ?? '',
          addressRoad: state.arrestFromOne!.addressRoad ?? '',
          addressSoi: state.arrestFromOne!.addressSoi ?? '',
          subDistrict: state.arrestFromOne!.subDistrict ?? null,
          district: state.arrestFromOne!.district ?? null,
          province: state.arrestFromOne!.province ?? null,
          phoneNumber: state.arrestFromOne!.phoneNumber ?? '',
          employerFullname: state.arrestFromTwo!.employerFullname ?? '',
          truckBrand: state.arrestFromTwo!.truckBrand ?? '',
          vehicleRegistrationPlate: state.arrestFromTwo!.vehicleRegistrationPlate ?? '',
          vehicleType: state.arrestFromTwo!.vehicleType ?? '',
          vehicleAxle: state.arrestFromTwo!.vehicleAxle ?? '',
          vehicleRubber: state.arrestFromTwo!.vehicleRubber ?? '',
          vehicleTowType: state.arrestFromTwo!.vehicleTowType ?? null,
          towVehicleRegistrationPlateTail: state.arrestFromTwo!.towVehicleRegistrationPlateTail ?? '',
          towType: state.arrestFromTwo!.towType ?? '',
          towAxle: state.arrestFromTwo!.towAxle ?? '',
          towRubber: state.arrestFromTwo!.towRubber ?? '',
          distanceKingpin: state.arrestFromTwo!.distanceKingpin ?? '',
          truckCarrierType: state.arrestFromTwo!.truckCarrierType ?? null,
          ruralRoadNumber: state.arrestFromTwo!.ruralRoadNumber ?? '',
          sourceProvince: state.arrestFromTwo!.sourceProvince ?? null,
          destinationProvince: state.arrestFromTwo!.destinationProvince ?? null,
          weightStationType: state.arrestFromTwo!.weightStationType ?? null,
          explain: state.arrestFromTwo!.explain ?? '',
          truckTotalWeight: state.arrestFromThree!.truckTotalWeight ?? '',
          legalWeight: state.arrestFromThree!.legalWeight ?? '',
          overWeight: state.arrestFromThree!.overWeight ?? '',
          annoucementNo: state.arrestFromThree!.annoucementNo ?? '',
          truckRegistrationPlate: state.arrestFromThree!.truckRegistrationPlate ?? '',
          truckRegistrationPlateCopy: state.arrestFromThree!.truckRegistrationPlateCopy ?? '',
          truckLicenseType: state.arrestFromThree!.truckLicenseType ?? '',
          slipWeightFromCompany: state.arrestFromThree!.slipWeightFromCompany ?? '',
          slipWeightFromWeightUnit: state.arrestFromThree!.slipWeightFromWeightUnit ?? '',
          localeRuralRoadNo: state.arrestFromFour!.localeRuralRoadNo ?? '',
          localeKm: state.arrestFromFour!.localeKm ?? '',
          localeSubDistrict: state.arrestFromFour!.localeSubDistrict ?? null,
          localeDistrict: state.arrestFromFour!.localeDistrict ?? null,
          localeProvince: state.arrestFromFour!.localeProvince ?? null,
          localeDate: state.arrestFromFour!.localeDate ?? '',
          localeTime: state.arrestFromFour!.localeTime ?? '',
          confesstion: state.arrestFromFour!.confesstion ?? null,
          confesstionOther: state.arrestFromFour!.confesstionOther ?? '',
          evidence: state.arrestFromFour!.evidence ?? 0,
          torture: state.arrestFromFour!.torture ?? 0,
          tellLaw: state.arrestFromFour!.tellLaw ?? 0,
          tellLawEmail: state.arrestFromFour!.tellLawEmail ?? '',
          tellLawDate: state.arrestFromFour!.tellLawDate ?? '',
          tellLawTime: state.arrestFromFour!.tellLawTime ?? '',
          tellLawProsecutor: state.arrestFromFour!.tellLawProsecutor ?? 0,
          tellLawProsecutorEmail: state.arrestFromFour!.tellLawProsecutorEmail ?? '',
          tellLawProsecutorDate: state.arrestFromFour!.tellLawProsecutorDate ?? '',
          tellLawProsecutorTime: state.arrestFromFour!.tellLawProsecutorTime ?? '',
          provincialAdmin: state.arrestFromFour!.provincialAdmin ?? 0,
          isNotRecord: state.arrestFromFour!.isNotRecord ?? '',
          policeStation: state.arrestFromFour!.policeStation ?? '',
          employerOwner: state.arrestFromFour!.employerOwner ?? '',
          truckOwner: state.arrestFromFour!.truckOwner ?? '',
          factoryData: state.arrestFromFour!.factoryData ?? '',
        );

        var body = json.encode(payload);
        final response = await arrestRepo.putArrestLogs(state.arrestLogDetail!.id.toString(), body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          String arrestFormPostId = response.data['data']['id'];

          emit(state.copyWith(arrestFormPostId: arrestFormPostId));
          emit(state.copyWith(arrestFormStatus: ArrestFormStatus.success));
          return;
        }

        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: e.toString()));
        return;
      }
    });

    on<UpdateArrestFormEvent>((event, emit) async {
      try {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.loading));

        var body = json.encode(event.payload.toJson());
        final response = await arrestRepo.putArrestLogs(event.tdId, body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(arrestFormStatus: ArrestFormStatus.success));
          return;
        }

        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.error, arrestError: e.toString()));
        return;
      }
    });

    on<ClearFormEvent>((event, emit) async {
      emit(state.copyWith(arrestForm: ArrestFormReq.empty()));
      return;
    });

    on<StepOneFormEvent>((event, emit) async {
      try {
        logger.i(event.payload.toJson());
        emit(state.copyWith(arrestFromOne: event.payload));
        logger.i(event.payload.toJson());
        return;
      } catch (e) {
        return;
      }
    });

    on<StepTwoFormEvent>((event, emit) async {
      try {
        logger.i(event.payload.toJson());
        emit(state.copyWith(arrestFromTwo: event.payload));
        logger.i(event.payload.toJson());
        return;
      } catch (e) {
        return;
      }
    });

    on<StepThreeFormEvent>((event, emit) async {
      try {
        logger.i(event.payload.toJson());
        emit(state.copyWith(arrestFromThree: event.payload));
        logger.i(event.payload.toJson());
        return;
      } catch (e) {
        return;
      }
    });

    on<StepFourFormEvent>((event, emit) async {
      try {
        logger.i(event.payload.toJson());
        emit(state.copyWith(arrestFromFour: event.payload));
        logger.i(event.payload.toJson());
        return;
      } catch (e) {
        return;
      }
    });

    on<ClearFomrArrestEvent>((event, emit) async {
      try {
        emit(state.copyWith(arrestFormStatus: ArrestFormStatus.initial, arrestError: ''));
        emit(state.copyWith(arrestFromOne: ArrestFormStepOneReq.empty()));
        emit(state.copyWith(arrestFromTwo: ArrestFormStepTwoReq.empty()));
        emit(state.copyWith(arrestFromThree: ArrestFormStepThreeReq.empty()));
        emit(state.copyWith(arrestFromFour: ArrestFormStepFourReq.empty()));
        emit(state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.initial, arrestLogDetailError: '', arrestLogDetail: ArrestLogDetailModelRes.empty()));

        return;
      } catch (e) {
        return;
      }
    });

    on<GetArrestLogDetail>((event, emit) async {
      try {
        emit(state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.loading));

        final response = await arrestRepo.getArrestLogsShow(event.arrestId);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = ArrestLogDetailModelRes.fromJson(response.data['data']);

          emit(state.copyWith(arrestLogDetail: result));

          emit(state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.success));
          return;
        }
        emit(state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.error, arrestLogDetailError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(arrestLogDetailStatus: ArrestLogDetailStatus.error, arrestLogDetailError: e.toString()));

        return;
      }
    });
  }
}
