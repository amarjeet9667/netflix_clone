// lib/features/home/data/datasources/home_remote_datasource.dart

// ✅ Fixed: removed unused AppConfig import
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/config/app_config.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/home_section_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BannerEntity>>      getFeaturedBanners();
  Future<List<HomeSectionEntity>> getHomeSections();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;
  const HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<BannerEntity>> getFeaturedBanners() async {
    // ✅ In test env, serve dummy data; in prod, call real API
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyBanners.featuredBanners
          .map((e) => BannerEntity.fromJson(e))
          .toList();
    }

    // Prod: uncomment when real API is ready
    // final response = await apiClient.get(ApiHomeConstants.featuredBanners);
    // return (response['banners'] as List)
    //     .map((e) => BannerEntity.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 200));
    return DummyBanners.featuredBanners
        .map((e) => BannerEntity.fromJson(e))
        .toList();
  }

  @override
  Future<List<HomeSectionEntity>> getHomeSections() async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyHomeSections.sections
          .map((e) => HomeSectionEntity.fromJson(e))
          .toList();
    }

    // Prod: uncomment when real API is ready
    // final response = await apiClient.get(ApiHomeConstants.sections);
    // return (response['sections'] as List)
    //     .map((e) => HomeSectionEntity.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 200));
    return DummyHomeSections.sections
        .map((e) => HomeSectionEntity.fromJson(e))
        .toList();
  }
}