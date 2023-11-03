import 'package:pokemongetx/src/domain/models/model.dart';

abstract class ParamUseCase {
  Future<PokelistResponseModel> executePokeList(String url);
  Future<PokemonDetailInfoResponseModel> executeMonsterDetailInfo(String url);
}
