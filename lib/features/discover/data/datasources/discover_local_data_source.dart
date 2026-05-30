import 'package:striv/features/discover/data/models/feed_post_model.dart';
import 'package:striv/features/discover/data/models/reel_model.dart';
import 'package:striv/features/discover/data/models/startup_pitch_model.dart';

abstract class DiscoverLocalDataSource {
  Future<List<StartupPitchModel>> getSwipeablePitches();
  Future<List<FeedPostModel>> getFeedPosts();
  Future<List<ReelModel>> getReels();
}

class DiscoverLocalDataSourceImpl implements DiscoverLocalDataSource {
  @override
  Future<List<StartupPitchModel>> getSwipeablePitches() async {
    return [
      const StartupPitchModel(
        id: '1',
        name: 'EcoTech Solutions',
        tagline: 'Sustainable fintech for the next generation',
        category: 'Fintech',
        posterImage: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400',
        fundingGoal: 500000,
        stage: 'Seed',
      ),
      const StartupPitchModel(
        id: '2',
        name: 'MediLink AI',
        tagline: 'Connecting patients to care with AI',
        category: 'HealthTech',
        posterImage: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=400',
        fundingGoal: 750000,
        stage: 'MVP',
      ),
      const StartupPitchModel(
        id: '3',
        name: 'EduBridge',
        tagline: 'Bridging the education gap globally',
        category: 'EdTech',
        posterImage: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400',
        fundingGoal: 250000,
        stage: 'Pre-Seed',
      ),
    ];
  }

  @override
  Future<List<FeedPostModel>> getFeedPosts() async {
    return [
      const FeedPostModel(
        id: 'p1',
        startupId: '1',
        startupName: 'EcoTech Solutions',
        ownerUsername: 'ecotech',
        avatarUrl: 'https://via.placeholder.com/48',
        caption: r'Just closed our seed round! 🎉 Excited to announce $500k raised.',
        imageUrls: ['https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800'],
        likes: 128,
        comments: 24,
        timeAgo: '2h ago',
      ),
      const FeedPostModel(
        id: 'p2',
        startupId: '2',
        startupName: 'MediLink AI',
        ownerUsername: 'medilink',
        avatarUrl: 'https://via.placeholder.com/48',
        caption: 'Our AI diagnostic tool just reached 95% accuracy. Game changer for rural healthcare.',
        imageUrls: [],
        likes: 87,
        comments: 15,
        timeAgo: '5h ago',
      ),
      const FeedPostModel(
        id: 'p3',
        startupId: '3',
        startupName: 'EduBridge',
        ownerUsername: 'edubridge',
        avatarUrl: 'https://via.placeholder.com/48',
        caption: 'We now support 12 regional languages. Education for everyone. 📚',
        imageUrls: ['https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800'],
        likes: 214,
        comments: 42,
        timeAgo: 'Yesterday',
      ),
    ];
  }

  @override
  Future<List<ReelModel>> getReels() async {
    return const [
      ReelModel(
        id: 'reel@1',
        startupId: '1',
        startupName: 'Blender Foundation',
        ownerUsername: 'blender',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        caption: 'Check out this amazing open-source animation!',
      ),
      ReelModel(
        id: 'reel@2',
        startupId: '2',
        startupName: 'Blender Studio',
        ownerUsername: 'blendero',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        caption: 'Sintel — short film clip 🎬',
      ),
      ReelModel(
        id: 'reel@3',
        startupId: '3',
        startupName: 'Pixar Demo',
        ownerUsername: 'pixar_demo',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
        caption: 'Tears of Steel sci-fi short film',
      ),
    ];
  }
}
