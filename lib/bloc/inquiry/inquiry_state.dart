part of 'inquiry_bloc.dart';

abstract class InquiryState extends Equatable {
  const InquiryState();
  
  @override
  List<Object> get props => [];
}

class InquiryInitial extends InquiryState {
  @override
  List<Object> get props => [];
}

class InquiryLoading extends InquiryState {
  @override
  List<Object> get props => [];
}

class MissingProductReported extends InquiryState {
  @override
  List<Object> get props => [];
}