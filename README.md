# MedKnowledge AI – starter project

Android-first Flutter + FastAPI starter.

## Included
- Home, Learn, Medical Updates and Profile screens
- English/Kannada language toggle for sample labels
- Starter menstrual-cycle, skin and hair chapters
- Medical updates feed UI with review-status labels
- FastAPI backend with health and updates endpoints
- SQLite storage and an RSS polling scaffold

## Run backend
```bash
cd backend
python -m venv .venv
# Windows: .venv\\Scripts\\activate
# macOS/Linux: source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
API docs: http://127.0.0.1:8000/docs

## Run Flutter
First generate the Android platform folders inside the Flutter project:
```bash
cd flutter_app
flutter create .
flutter pub get
flutter run
```

The app currently uses sample local content. Android emulator backend URL is
`http://10.0.2.2:8000`; a physical phone should use the computer's LAN IP.
Use HTTPS in production.

## Not production-ready yet
Live official-source integrations, medical expert review, Firebase push notifications,
authentication, privacy/security hardening and regulatory review remain to be implemented.
The RSS feed list is intentionally empty until valid sources and access terms are checked.
Do not publish unreviewed AI-generated medical guidance.
