// https://pokeapi.co/api/v2/pokemon/ + id

import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class PokemonNotifier extends StateNotifier<AsyncValue<Map>> {
  // 初期値はloading状態にしておく
  PokemonNotifier() : super(const AsyncValue.loading()) {
    fetchRandomPokemon();
  }

  Future<void> fetchRandomPokemon() async {
    final randomId = Random().nextInt(150);

    // ランダムなidのポケモンjson
    final url = Uri.https('pokeapi.co', 'api/v2/pokemon/$randomId');

    // 状態をローディングに変更
    state = const AsyncValue.loading();

    final response = await http.get(url);
    try {
      state = AsyncValue.data(jsonDecode(response.body));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final pokemonProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<Map>>((ref) {
  return PokemonNotifier();
});
