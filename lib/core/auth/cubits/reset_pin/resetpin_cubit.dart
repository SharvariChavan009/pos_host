import 'package:bloc/bloc.dart';


part 'resetpin_state.dart';

class ResetpinCubit extends Cubit<ResetpinState> {
  ResetpinCubit() : super(ResetpinInitial());
}
