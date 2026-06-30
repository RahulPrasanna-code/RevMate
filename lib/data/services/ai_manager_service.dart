import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'claude_chat_service.dart';
import 'gemini_chat_service.dart';

enum AIEngine { claude, gemini }

final aiEngineProvider = StateProvider<AIEngine>((ref) => AIEngine.gemini);

final aiManagerProvider = Provider((ref) => AIManagerService(ref));

class AIManagerService {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AIManagerService(this._ref);

  Future<void> init() async {
    final engineStr = await _storage.read(key: 'ai_engine');
    if (engineStr != null) {
      _ref.read(aiEngineProvider.notifier).state = 
          engineStr == 'claude' ? AIEngine.claude : AIEngine.gemini;
    }
  }

  Future<void> setEngine(AIEngine engine) async {
    _ref.read(aiEngineProvider.notifier).state = engine;
    await _storage.write(key: 'ai_engine', value: engine == AIEngine.claude ? 'claude' : 'gemini');
  }

  Future<String> sendMessage(String text) async {
    final engine = _ref.read(aiEngineProvider);
    if (engine == AIEngine.claude) {
      return await _ref.read(chatServiceProvider).sendMessage(text);
    } else {
      return await _ref.read(geminiServiceProvider).sendMessage(text);
    }
  }

  Future<String> getNudge() async {
    final engine = _ref.read(aiEngineProvider);
    if (engine == AIEngine.claude) {
      return await _ref.read(chatServiceProvider).getNudge();
    } else {
      return await _ref.read(geminiServiceProvider).getNudge();
    }
  }

  List<ChatMessage> get history {
    final engine = _ref.read(aiEngineProvider);
    if (engine == AIEngine.claude) {
      return _ref.read(chatServiceProvider).history;
    } else {
      // Mapping Gemini history if needed, but for now they use the same model
      final geminiHistory = _ref.read(geminiServiceProvider).history;
      return geminiHistory;
    }
  }
}
