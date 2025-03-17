part of 'main_page_bloc.dart';

sealed class MainPageEvent {
  const MainPageEvent();
}

class MainPageEventRefresh extends MainPageEvent {}
