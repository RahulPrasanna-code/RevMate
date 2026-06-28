import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleDetails {
  final String registrationNumber;
  final String? make;
  final String? model;
  final int? year;
  final String? fuelType;
  final String? engineCC;
  final String? colour;
  final DateTime? insuranceExpiry;
  final DateTime? pucExpiry;
  final String? ownerName;

  VehicleDetails({
    required this.registrationNumber,
    this.make,
    this.model,
    this.year,
    this.fuelType,
    this.engineCC,
    this.colour,
    this.insuranceExpiry,
    this.pucExpiry,
    this.ownerName,
  });
}

class VehicleLookupService {
  final String baseUrl;

  VehicleLookupService({
    this.baseUrl = 'https://vehicle-rc-information-v2.p.rapidapi.com/',
  });

  /// Lookup a vehicle by plate. Returns null when not found.
  Future<Map<String, dynamic>?> _callApi(
    String plate,
    Map<String, String> headers,
  ) async {
    final uri = Uri.parse(baseUrl);
    final body = jsonEncode({'vehicle_number': plate});
    print('VehicleLookupService: POST $uri body=$body');
    try {
      final resp = await http
          .post(
            uri,
            headers: {...headers, 'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 10));
      print(
        'VehicleLookupService: raw response: ${resp.statusCode} ${resp.body} ${headers}',
      );
      if (resp.statusCode == 200) {
        final js = jsonDecode(resp.body);
        if (js is Map<String, dynamic>) {
          if (js['response'] is Map<String, dynamic>) {
            return js['response'] as Map<String, dynamic>;
          }
          return js;
        }
        // some APIs return a list
        if (js is List && js.isNotEmpty && js.first is Map<String, dynamic>) {
          return js.first as Map<String, dynamic>;
        }
        return null;
      }
      // propagate status for caller to map to messages
      throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
    } catch (e, st) {
      print('VehicleLookupService: exception $e');
      print(st);
      rethrow;
    }
  }

  Future<VehicleDetails?> lookupByPlate(
    String plate,
    Map<String, String> headers,
    DateTime? Function(String?)? parseDate,
  ) async {
    try {
      final Map<String, dynamic>? raw = await _callApi(plate, headers);
      if (raw == null || raw.isEmpty) {
        print('VehicleLookupService: response did not contain vehicle data');
        return null;
      }

      print('VehicleLookupService: raw json -> $raw');

      String reg = raw['license_plate']?.toString() ?? plate;
      String? make =
          raw['brand_name'] ??
          raw['maker'] ??
          raw['manufacturer'] ??
          raw['make'];
      String? model = raw['brand_model'] ?? raw['model'];
      int? year;
      final manufDateFormatted = raw['manufacturing_date_formatted']
          ?.toString();
      final manufDate = raw['manufacturing_date']?.toString();
      if (manufDateFormatted != null && manufDateFormatted.contains('-')) {
        year = int.tryParse(manufDateFormatted.split('-').first);
      } else if (manufDate != null && manufDate.contains('/')) {
        final parts = manufDate.split('/');
        if (parts.length == 2) {
          year = int.tryParse(parts[1]);
        }
      }
      year ??= int.tryParse(raw['year']?.toString() ?? '');
      String? fuelType = raw['fuel_type'] ?? raw['fuelType'] ?? raw['fuel'];
      String? engineCC =
          raw['cubic_capacity']?.toString() ?? raw['engineCC']?.toString();
      String? colour = raw['color'] ?? raw['colour'];
      final insuranceRaw =
          raw['insurance_expiry'] ??
          raw['insuranceExpiry'] ??
          raw['insurance_validity'];
      final pucRaw =
          raw['pucc_upto'] ??
          raw['puc_upto'] ??
          raw['puc_validity'] ??
          raw['pucExpiry'];
      final ownerName = raw['owner_name'] ?? raw['ownerName'];

      DateTime? insuranceExpiry;
      DateTime? pucExpiry;
      try {
        if (parseDate != null) {
          insuranceExpiry = parseDate(insuranceRaw?.toString());
          pucExpiry = parseDate(pucRaw?.toString());
        }
      } catch (_) {}

      return VehicleDetails(
        registrationNumber: reg,
        make: make,
        model: model,
        year: year,
        fuelType: fuelType,
        engineCC: engineCC,
        colour: colour,
        insuranceExpiry: insuranceExpiry,
        pucExpiry: pucExpiry,
        ownerName: ownerName,
      );
    } on http.ClientException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
