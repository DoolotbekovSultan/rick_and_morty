part of 'characters_bloc.dart';

sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoadedSuccess extends CharactersState {
  final List<Character> characters;
  CharactersLoadedSuccess(this.characters);
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
