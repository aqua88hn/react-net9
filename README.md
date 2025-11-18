# QuizziApp

This repository contains a scaffold for QuizziApp using React + TypeScript + Tailwind (frontend) and ASP.NET Core (.NET 10) Web API (backend) with EF Core (Postgres) and JWT auth placeholders.

Quick start (macOS, zsh):

1) Backend

```bash
cd backend
dotnet restore
dotnet build
dotnet run --project ./  # or use your IDE
```

Set the connection string and Jwt:Key in `appsettings.json` or environment variables before running.

2) Frontend

```bash
cd frontend
npm install
npm run dev
```

Environment: create `.env` with `VITE_API_URL` pointing to backend base URL.

---

## Using the project generator

This repository includes a generator script that scaffolds a ready starter called `react-dotnet10-clean`.

- Script location: `scripts/create-template.sh`
- Make it executable and run from the repository root. Example:

```bash
chmod +x ./scripts/create-template.sh
./scripts/create-template.sh --with-auth --with-migrations
```

Flags:
- `--no-auth` — omit auth scaffolding
- `--no-migrations` — omit EF migration placeholders
- `--no-docker` — do not generate `docker-compose.yml` and smoke-test
- `--no-postgres` — omit Postgres placeholders
- `--enable-ef-sensitive` — set `EFCore:EnableSensitiveDataLogging` to `true` in the generated `appsettings.Development.json` (use only for local debugging)

Generated output includes `.env.template`, `backend/src/Api/appsettings.Development.json`, `backend/src/Api/appsettings.Production.json`, and optional `backend/scripts/migrate.sh`, `docker-compose.yml` and `scripts/smoke-test.sh` depending on flags.

Security note: Keep `EFCore:EnableSensitiveDataLogging` disabled in production. Do not commit real secrets — use environment variables or secret stores for CI/production.
