import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Cocoverde/shared/models/user.dart';
import 'package:Cocoverde/shared/repository/account_repository.dart';

part 'main_events.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AccountRepository _accountRepository;

  MainBloc({required AccountRepository accountRepository}) :
        _accountRepository = accountRepository, super(const MainState());

  @override
  void onTransition(Transition<MainEvent, MainState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is Init) {
       yield* onInit(event);
    }
  }

  Stream<MainState> onInit(Init event) async* {
    User? currentUser = await _accountRepository.getIdentity();


    yield state.copyWith(
      currentUser: currentUser,
    );
  }
}
