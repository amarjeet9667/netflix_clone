import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/home_section_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BannerEntity>> getFeaturedBanners();
  Future<List<HomeSectionEntity>> getHomeSections();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;
  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<BannerEntity>> getFeaturedBanners() async {
    // In actual server environments we might do: final response = await apiClient.get('/banners');
    await Future.delayed(const Duration(milliseconds: 200));
    return DummyBanners.featuredBanners.map((e) => BannerEntity.fromJson(e)).toList();
  }

  @override
  Future<List<HomeSectionEntity>> getHomeSections() async {
    // In actual server environments we might do: final response = await apiClient.get('/home-sections');
    await Future.delayed(const Duration(milliseconds: 200));
    return DummyHomeSections.sections.map((e) => HomeSectionEntity.fromJson(e)).toList();
  }
}
