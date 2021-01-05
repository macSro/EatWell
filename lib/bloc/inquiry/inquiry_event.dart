part of 'inquiry_bloc.dart';

abstract class InquiryEvent extends Equatable {
  const InquiryEvent();

  @override
  List<Object> get props => [];
}

class ReportMissingProduct extends InquiryEvent {
  final String productName;

  ReportMissingProduct({@required this.productName});

  @override
  List<Object> get props => [productName];
}

class ResetMissingReportResult extends InquiryEvent {
  @override
  List<Object> get props => [];
}