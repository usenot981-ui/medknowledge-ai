# Backend notes

- GET `/health`: service health
- GET `/updates`: list collected update records
- POST `/updates`: add an update, stored as `under_review`
- POST `/admin/poll-rss`: demonstration RSS collector; feed list is intentionally empty

Before production:
- Protect admin routes with authentication and role-based access.
- Configure official RSS/API sources only after verifying access terms.
- Add source-specific parsing, deduplication and provenance.
- Require clinician/editor review before marking items verified.
- Add audit logs, publication date, review date and version history.
- Implement Firebase Cloud Messaging for Android push notifications.
- Do not let unreviewed research overwrite clinical recommendations.
