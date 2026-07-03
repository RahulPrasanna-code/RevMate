import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';
import '../providers.dart';

final chatServiceProvider = Provider((ref) => ClaudeChatService(ref));

class ChatMessage {
  final String role;
  final String content;
  ChatMessage({required this.role, required this.content});
  Map<String, String> toJson() => {'role': role, 'content': content};
}

class ClaudeChatService {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();
  final List<ChatMessage> _history = [];

  ClaudeChatService(this._ref);

  Future<String> sendMessage(String text) async {
    final apiKey = await _storage.read(key: 'anthropic_key');
    if (apiKey == null || apiKey.isEmpty) return 'Please set your Anthropic API key in Profile.';

    _history.add(ChatMessage(role: 'user', content: text));

    final db = _ref.read(dbProvider);
    final bikes = await db.watchAllBikes().first;
    final bikeContext = bikes.isNotEmpty ? await _buildContext(bikes.first, db) : 'No bike data available.';

    final systemPrompt = """
You are RevMate, a motorcycle companion assistant. 
Here is the current bike data:
$bikeContext

Use this context to provide helpful, concise advice to the rider. 
You have access to web search for accessory and community suggestions.
""";

    try {
      final response = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': 'claude-3-5-sonnet-20240620',
          'max_tokens': 1000,
          'system': systemPrompt,
          'messages': _history.map((m) => m.toJson()).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['content'][0]['text'] as String;
        _history.add(ChatMessage(role: 'assistant', content: reply));
        return reply;
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Exception: $e';
    }
  }

  Future<String> getNudge() async {
    final apiKey = await _storage.read(key: 'anthropic_key');
    if (apiKey == null || apiKey.isEmpty) return '';

    final db = _ref.read(dbProvider);
    final bikes = await db.watchAllBikes().first;
    if (bikes.isEmpty) return '';

    final bikeContext = await _buildContext(bikes.first, db);

    try {
      final response = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': 'claude-3-5-sonnet-20240620',
          'max_tokens': 500,
          'system': 'You are RevMate. Given the bike data, return ONE short actionable reminder for the rider today. Be conversational, max 2 sentences.',
          'messages': [{'role': 'user', 'content': 'Here is my bike data: $bikeContext. What is my nudge for today?'}],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'][0]['text'] as String;
      }
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
