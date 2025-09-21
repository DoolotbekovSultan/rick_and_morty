import 'package:bloc/bloc.dart';
import 'package:rick_and_morty/features/character/domain/entities/character.dart';
import 'package:rick_and_morty/features/character/domain/usecases/get_characters_usecase.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUsecase getCharactersUsecase;
  int? nextPage = 0;
  int? prevPage = 0;
  CharactersBloc(this.getCharactersUsecase) : super(CharactersInitial()) {
    on<LoadCharactersEvent>(_onLoadCharacters);
    on<LoadNextPageEvent>(_onLoadNextPage);
    on<LoadPrevPageEvent>(_onLoadPrevPage);
  }

  Future<void> _onLoadCharacters(
    LoadCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    final result = await getCharactersUsecase(event.page);
    nextPage = result.next;
    prevPage = result.prev;
    emit(CharactersLoadedSuccess(result.characters));
  }

  Future<void> _onLoadNextPage(
    LoadNextPageEvent event,
    Emitter<CharactersState> emit,
  ) async {
    if (nextPage != null) {
      add(LoadCharactersEvent(nextPage!));
    }
  }

  Future<void> _onLoadPrevPage(
    LoadPrevPageEvent event,
    Emitter<CharactersState> emit,
  ) async {
    if (prevPage != null) {
      add(LoadCharactersEvent(prevPage!));
    }
  }
}
