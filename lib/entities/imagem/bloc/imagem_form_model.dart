import 'package:formz/formz.dart';
import 'package:cocoverde/entities/imagem/imagem_model.dart';
import 'package:time_machine/time_machine.dart';

enum NameValidationError { invalid }
class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return null;
  }
}

enum ContentTypeValidationError { invalid }
class ContentTypeInput extends FormzInput<String, ContentTypeValidationError> {
  const ContentTypeInput.pure() : super.pure('');
  const ContentTypeInput.dirty([String value = '']) : super.dirty(value);

  @override
  ContentTypeValidationError? validator(String value) {
    return null;
  }
}

enum DescriptionValidationError { invalid }
class DescriptionInput extends FormzInput<String, DescriptionValidationError> {
  const DescriptionInput.pure() : super.pure('');
  const DescriptionInput.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String value) {
    return null;
  }
}

