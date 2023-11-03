import 'package:pokemongetx/src/config/usecases/pram_usecase.dart';
import 'package:pokemongetx/src/domain/models/pokelist_response_model.dart';
import 'package:pokemongetx/src/domain/models/pokemon_detail_info_response_model.dart';
import 'package:pokemongetx/src/domain/repositories/domain_repository.dart';

class UseCase extends ParamUseCase {
  UseCase(this._repo);
  final DomainRepository _repo;

  @override
  Future<PokelistResponseModel> executePokeList(String url) {
    return _repo.getPokelistDomainRepository(url);
  }

  @override
  Future<PokemonDetailInfoResponseModel> executeMonsterDetailInfo(String url) {
    return _repo.getMonsterDetailInfoDomainRepository(url);
  }



}
