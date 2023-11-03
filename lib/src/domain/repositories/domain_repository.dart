import 'package:pokemongetx/src/domain/models/model.dart';

abstract class DomainRepository {
  Future<PokelistResponseModel> getPokelistDomainRepository(String url);

  Future<PokemonDetailInfoResponseModel> getMonsterDetailInfoDomainRepository(String url);
}
