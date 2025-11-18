#!/usr/bin/env bash
set -euo pipefail

##############################################
# Clean Architecture Template Generator
# React (Vite + Tailwind) + .NET 10 API
# Generates: react-dotnet10-clean.zip
##############################################

BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== React + .NET 10 Clean Architecture Project Generator ===${NC}"

# -------------------------------------------------------------------
# Parse flags
# -------------------------------------------------------------------
WITH_AUTH=true
WITH_MIGRATIONS=true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-auth)
      WITH_AUTH=false
      shift
      ;;
    --no-migrations)
      WITH_MIGRATIONS=false
      shift
      ;;
    --help)
      echo "Usage: create_template.sh [--no-auth] [--no-migrations]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# -------------------------------------------------------------------
# Prepare output directory
# -------------------------------------------------------------------
OUTDIR="react-dotnet10-clean"
ZIPFILE="react-dotnet10-clean.zip"

rm -rf "$OUTDIR" "$ZIPFILE"
mkdir -p "$OUTDIR"

echo -e "${GREEN}✓ Output directory created: $OUTDIR${NC}"

# -------------------------------------------------------------------
# Create folder structure
# -------------------------------------------------------------------
echo -e "${BLUE}→ Creating folder structure...${NC}"

dirs=(
  "backend/src/Core/Entities"
  "backend/src/Core/Interfaces"
  "backend/src/Core/Exceptions"
  "backend/src/Core/ValueObjects"

  "backend/src/Application/DTOs"
  "backend/src/Application/Features/Users"
  "backend/src/Application/Features/Todos"
  "backend/src/Application/Services"
  "backend/src/Application/Validators"

  "backend/src/Infrastructure/Persistence/Configurations"
  "backend/src/Infrastructure/Persistence/Migrations"
  "backend/src/Infrastructure/Persistence/RepositoryImpl"
  "backend/src/Infrastructure/Auth"
  "backend/src/Infrastructure/Services"

  "backend/src/Api/Controllers"
  "backend/src/Api/Filters"
  "backend/src/Api/Middleware"
  "backend/src/Api/Configurations"

  "frontend/src/components"
  "frontend/src/pages"
  "frontend/src/routes"
  "frontend/src/hooks"
  "frontend/src/store"
  "frontend/src/services"
  "frontend/src/styles"
  "frontend/src/utils"

  ".vscode"
)

for d in "${dirs[@]}"; do
  mkdir -p "$OUTDIR/$d"
done

echo -e "${GREEN}✓ Folder structure generated${NC}"

# -------------------------------------------------------------------
# Backend files (Program.cs, csproj, controllers, DI, etc.)
# -------------------------------------------------------------------

cat > "$OUTDIR/backend/src/Api/Program.cs" << 'EOF'
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
app.UseSwagger();
app.UseSwaggerUI();
app.MapControllers();

app.Run();
EOF

cat > "$OUTDIR/backend/src/Api/Api.csproj" << 'EOF'
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
    <Nullable>enable</Nullable>
  </PropertyGroup>

</Project>
EOF

cat > "$OUTDIR/backend/src/Api/Controllers/HealthController.cs" << 'EOF'
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Check() => Ok(new { status = "OK", time = DateTime.UtcNow });
}
EOF

cat > "$OUTDIR/backend/src/Core/Core.csproj" << 'EOF'
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
  </PropertyGroup>

</Project>
EOF

cat > "$OUTDIR/backend/src/Application/Application.csproj" << 'EOF'
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <ProjectReference Include="../Core/Core.csproj" />
  </ItemGroup>

</Project>
EOF

cat > "$OUTDIR/backend/src/Infrastructure/Infrastructure.csproj" << 'EOF'
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <ProjectReference Include="../Application/Application.csproj" />
  </ItemGroup>

</Project>
EOF

cat > "$OUTDIR/backend/backend.sln" << 'EOF'
Microsoft Visual Studio Solution File, Format Version 12.00
# Placeholder — user will run: dotnet new sln; dotnet sln add
EOF

echo -e "${GREEN}✓ Backend minimal files added${NC}"

# -------------------------------------------------------------------
# Optional Auth
# -------------------------------------------------------------------
if [ "$WITH_AUTH" = true ]; then
  echo -e "${BLUE}→ Adding Auth placeholder...${NC}"

cat > "$OUTDIR/backend/src/Infrastructure/Auth/AuthService.cs" << 'EOF'
namespace Infrastructure.Auth;

public class AuthService
{
    public string IssueToken(string user)
    {
        return "JWT_TOKEN_PLACEHOLDER";
    }
}
EOF

fi

# -------------------------------------------------------------------
# Optional EF Migrations
# -------------------------------------------------------------------
if [ "$WITH_MIGRATIONS" = true ]; then
  echo -e "${BLUE}→ Adding EF storage placeholders (no DB execution)...${NC}"

cat > "$OUTDIR/backend/src/Infrastructure/Persistence/AppDbContext.cs" << 'EOF'
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Persistence;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }
}
EOF

fi

# -------------------------------------------------------------------
# Frontend (React + Vite + Tailwind) — placeholders only
# -------------------------------------------------------------------
cat > "$OUTDIR/frontend/package.json" << 'EOF'
{
  "name": "react-app",
  "private": true,
  "version": "0.0.1"
}
EOF

cat > "$OUTDIR/frontend/src/pages/Home.jsx" << 'EOF'
export default function Home() {
  return <div className="text-xl p-4">React + Tailwind + .NET 10 Template</div>;
}
EOF

# -------------------------------------------------------------------
# VS Code configuration
# -------------------------------------------------------------------
cat > "$OUTDIR/.vscode/tasks.json" << 'EOF'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Backend",
      "type": "shell",
      "command": "dotnet run --project backend/src/Api/Api.csproj",
      "problemMatcher": []
    }
  ]
}
EOF

# -------------------------------------------------------------------
# README for the generated template
# -------------------------------------------------------------------
cat > "$OUTDIR/README.md" << 'EOF'
# React + .NET 10 Clean Architecture Template

## Run Backend
```bash
cd backend
dotnet restore
dotnet build
dotnet run --project src/Api/Api.csproj
