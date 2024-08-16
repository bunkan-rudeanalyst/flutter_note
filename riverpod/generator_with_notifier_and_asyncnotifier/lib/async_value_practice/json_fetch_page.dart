import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generator_with_notifier_and_asyncnotifier/async_value_practice/fetch_pokemon.dart';

class JsonFetchPage extends ConsumerWidget {
  const JsonFetchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomPokemon = ref.watch(pokemonProvider);
    return Scaffold(
      body: Center(
        child: randomPokemon.when(
            data: (pokemon) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                          pokemon["sprites"]["other"]["official-artwork"]
                              ["front_default"],
                          fit: BoxFit.fill),
                    ),
                    Text(
                      pokemon["name"],
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
            error: (_, __) => const Text('error'),
            loading: () => CircularProgressIndicator(
                  color: Colors.blue,
                )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('change pokemon'),
        onPressed: () {
          ref.read(pokemonProvider.notifier).fetchRandomPokemon();
        },
      ),
    );
  }
}
