# RevMate — Motorcycle Companion App

## What is this?
A personal Android-only motorcycle companion app built with Flutter.
Single bike, offline-first, Material 3 throughout, with Claude AI chat built in.

## My Background
I am a backend/cloud engineer (AWS, Micronaut, EKS, SQS). 
Flutter/Dart is not my primary stack so explain decisions briefly when making them.
Always ask before introducing dependencies not listed below.

## Tech Stack
- Flutter (Android only)
- State: Riverpod
- Database: Drift (SQLite)
- Maps: flutter_map + geolocator
- Notifications: flutter_local_notifications
- AI: Anthropic Claude API (claude-sonnet-4-6) called directly via http
- Secure storage: flutter_secure_storage
- Theme: Material 3, ColorScheme.fromSeed(), light + dark

## Dependencies (pubspec.yaml)
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  drift: ^2.20.0
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.4
  path: ^1.9.0
  flutter_map: ^7.0.2
  geolocator: ^13.0.1
  latlong2: ^0.9.1
  flutter_local_notifications: ^17.2.3
  http: ^1.2.2
  intl: ^0.19.0
  uuid: ^4.5.1
  flutter_secure_storage: ^9.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  drift_dev: ^2.20.0
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.1

## Folder Structure
lib/
  main.dart
  theme/
  data/
    database/
    models/
  features/
    bike_profile/
    fuel_log/
    service_log/
    expenses/
    dashboard/
    rides/
    chat/
  shared/
    widgets/
    utils/

## Data Models (Drift Tables)
- Bike: id, name, make, model, year, currentOdometer, insuranceExpiry, pucExpiry, photoPath
- FuelLog: id, bikeId, date, odometer, liters, costTotal, costPerLiter, fullTank(bool)
- ServiceLog: id, bikeId, date, odometer, serviceType, description, cost, nextDueOdometer, nextDueDate
- ExpenseLog: id, bikeId, date, category(enum: parts/accessory/repair/insurance/other), description, cost
- RideLog: id, bikeId, startTime, endTime, distanceKm, routePoints(JSON), startOdometer, endOdometer

## Build Phases
### Phase 1 — Data Layer
- Set up folder structure
- Create all Drift tables and DAOs with reactive Stream queries
- Run build_runner to generate code

### Phase 2 — Material 3 Theme
- ColorScheme.fromSeed() with deep orange/red seed (motorcycle vibe)
- Light + dark support
- useMaterial3: true
- Consistent typography

### Phase 3 — Core Screens
- Bike Profile: view/edit bike details, expiry countdown chips
- Dashboard: odometer, days to next service, monthly spend, avg fuel efficiency
- Fuel Log: list + FAB to add, auto-calc km/l between full tank entries
- Service Log: list + add, next due reminder chip
- Expense Log: list + add by category, monthly totals
- Bottom NavigationBar: Dashboard, Fuel, Service, Expenses, Profile

### Phase 4 — Notifications
- flutter_local_notifications with Android permissions
- Check on app launch for: service due (500km or 7 days), insurance/PUC expiry (30 days), tyre pressure (every 15 days)

### Phase 5 — Ride Tracking
- Start/Stop ride button
- geolocator tracks lat/lng during ride
- Save completed ride to RideLog
- Ride history list + flutter_map polyline view

### Phase 6 — Claude AI Chat
- Chat bubble UI screen
- POST to https://api.anthropic.com/v1/messages (claude-sonnet-4-6, max_tokens: 1000)
- System prompt includes live DB context: last service, fuel trend, expiries, monthly spend
- web_search tool enabled for accessory/community suggestions
- API key stored in flutter_secure_storage
- First launch prompts user to enter API key

### Phase 7 — Proactive AI Nudges
- Silent Claude API call on app open with full bike context
- Ask: "What is the most important thing to remind this rider today?"
- Show as in-app banner or local notification

## Rules for Claude Code
- Material 3 only, no M2 fallbacks
- Single bike scope, no multi-bike UI
- Offline first, no Firebase, no backend
- Always ask before adding unlisted dependencies
- One phase at a time, confirm with me before proceeding
- Brief explanations when making architectural decisions