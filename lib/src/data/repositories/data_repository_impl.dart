import 'package:pokemongetx/src/data/datasources/remote/remote_data_source.dart';
import 'package:pokemongetx/src/domain/models/pokelist_response_model.dart';
import 'package:pokemongetx/src/domain/models/pokemon_detail_info_response_model.dart';
import 'package:pokemongetx/src/domain/repositories/domain_repository.dart';

class DataRepositoryImpl implements DomainRepository {

  final RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();

  @override
  Future<PokelistResponseModel> getPokelistDomainRepository(String url) async {
    try {
      final PokelistResponseModel result = await remoteDataSourceImpl
          .getPokelistRemoteDataSource(url);
      return result;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PokemonDetailInfoResponseModel> getMonsterDetailInfoDomainRepository(String url) async {
    try {
      final PokemonDetailInfoResponseModel result = await remoteDataSourceImpl
          .getMonsterDetailInfoRemoteDataSource(url);
      return result;
    } catch (error) {
      rethrow;
    }
  }
}
