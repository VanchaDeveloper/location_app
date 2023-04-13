part of 'credential_cubit.dart';

abstract class CredentialState {}

class CredentialInitial extends CredentialState {}

class CredentialLoading extends CredentialState {}

class CredentialSuccess extends CredentialState {}

class CredentialFailure extends CredentialState {}
