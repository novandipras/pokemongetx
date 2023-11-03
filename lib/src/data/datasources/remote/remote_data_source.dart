import 'package:dio/dio.dart';
import 'package:pokemongetx/src/data/datasources/core_dio.dart';
import 'package:pokemongetx/src/domain/models/model.dart';

abstract class RemoteDataSource {
   Future<PokelistResponseModel> getPokelistRemoteDataSource(String url) ;
   Future<PokemonDetailInfoResponseModel> getMonsterDetailInfoRemoteDataSource(String url) ;
}

class RemoteDataSourceImpl implements RemoteDataSource {
   @override
  Future<PokelistResponseModel> getPokelistRemoteDataSource(String url) async {
    try {
      Response response = await CoreDio.instance.get(
        url,
      );
      PokelistResponseModel results =
      PokelistResponseModel.fromJson(
        response.data,
      );
      return results;
    } on DioException {
      rethrow;
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Future<PokemonDetailInfoResponseModel> getMonsterDetailInfoRemoteDataSource(String url) async {
    try {
      Response response = await CoreDio.instance.get(
        url,
      );
      PokemonDetailInfoResponseModel results =
      PokemonDetailInfoResponseModel.fromJson(
        response.data,
      );
      return results;
    } on DioException {
      rethrow;
    } catch (error) {
      throw error.toString();
    }
  }

}
