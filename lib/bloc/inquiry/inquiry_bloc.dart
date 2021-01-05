import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/repositories/inquiry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'inquiry_event.dart';
part 'inquiry_state.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {
  InquiryRepository _inquiryRepository;

  InquiryBloc({@required InquiryRepository inquiryRepository}) : super(InquiryInitial()) {
    this._inquiryRepository = inquiryRepository;
  }

  @override
  Stream<InquiryState> mapEventToState(InquiryEvent event) async* {
    if (event is ReportMissingProduct)
      yield* _reportMissingProduct(event.productName);
    else if (event is ResetMissingReportResult) yield* _resetMissingReportResult();
  }

  Stream<InquiryState> _reportMissingProduct(String productName) async* {
    yield InquiryLoading();

    await _inquiryRepository.reportMissingProduct(productName);

    yield MissingProductReported();
  }

  Stream<InquiryState> _resetMissingReportResult() async* {
    yield InquiryInitial();
  }
}
