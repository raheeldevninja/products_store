import 'package:products_store/features/home/home.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(const HomeState(currentIndex: 0)) {
    on<TabChangedEvent>(_onTabChangedEvent);
  }

  _onTabChangedEvent(TabChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

}