import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';
import '../providers.dart';
import 'claude_chat_service.dart';

final geminiServiceProvider = Provider((ref) => GeminiChatService(ref));

class GeminiChatService {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();
  final List<ChatMessage> _history = [];

  GeminiChatService(this._ref);

  Future<String> sendMessage(String text) async {
    final apiKey = await _storage.read(key: 'gemini_api_key');
    if (apiKey == null || apiKey.isEmpty) return 'Please set your Gemini API key in Profile.';

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    
    _history.add(ChatMessage(role: 'user', content: text));

    final db = _ref.read(dbProvider);
    final bikes = await db.watchAllBikes().first;
    final bikeContext = bikes.isNotEmpty ? await _buildContext(bikes.first, db) : 'No bike data available.';

    final systemPrompt = """
You are RevMate, a motorcycle companion assistant. 
Here is the current bike data:
$bikeContext

Use this context to provide helpful, concise advice to the rider. 
""";

    try {
      final content = [
        Content.text(systemPrompt),
        ..._history.map((m) => m.role == 'user' ? Content.text(m.content) : Content.model([TextPart(m.content)]))
      ];
      
      final response = await model.generateContent(content);
      final reply = response.text ?? 'No response from Gemini.';
      
      _history.add(ChatMessage(role: 'assistant', content: reply));
      return reply;
    } catch (e) {
      return 'Exception: $e';
    }
  }

  Future<String> getNudge() async {
    final apiKey = await _storage.read(key: 'gemini_api_key');
    if (apiKey == null || apiKey.isEmpty) return '';

    final db = _ref.read(dbProvider);
    final bikes = await db.watchAllBikes().first;
    if (bikes.isEmpty) return '';

    final bikeContext = await _buildContext(bikes.first, db);
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

    try {
      final response = await model.generateContent([
        Content.text('You are RevMate. Given the bike data, return ONE short actionable reminder for the rider today. Be conversational, max 2 sentences. Data: $bikeContext')
      ]);
      return response.text ?? '';
    } catch (_) {}
    return '';
  }

  Future<String> _buildContext(BikeData bike, RevMateDatabase db) async {
    final latestService = await db.getLatestServiceLog(bike.id);
    final fuelLogs = await db.watchFuelLogsByBike(bike.id).first;
    
    return """
Bike: ${bike.make} ${bike.model} (${bike.year})
Odometer: ${bike.currentOdometer} km
Insurance Expiry: ${bike.insuranceExpiry}
PUC Expiry: ${bike.pucExpiry}
Last Service: ${latestService?.date ?? 'N/A'} at ${latestService?.odometer ?? 'N/A'} km
Fuel Logs Count: ${fuelLogs.length}
""";
  }

  List<ChatMessage> get history => List.unmodifiable(_history);
}
