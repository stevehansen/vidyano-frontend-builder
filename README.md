# vidyano-frontend-builder

![Publish Front‑end Builder](https://github.com/stevehansen/vidyano-frontend-builder/actions/workflows/publish.yml/badge.svg)

Helper Docker image to build the frontend for Vidyano applications.  
No local Node.js required—just Docker Desktop.

---

## 🔧 Prerequisites

- Docker (Desktop) running on your machine  
- A `build-frontend.sh` script in your project root (see example below)  

---

## 🚀 Usage

Replace `MyApp` with your actual frontend folder name (if needed).

### Linux / macOS

```bash
docker run --rm \
  -v "$(pwd):/src" \
  -w /src \
  ghcr.io/stevehansen/vidyano-frontend-builder:latest
```

### Windows PowerShell

```powershell
docker run --rm `
  -v "${PWD}:/src" `
  -w "/src" `
  ghcr.io/stevehansen/vidyano-frontend-builder:latest
```

### Windows CMD

```cmd
docker run --rm ^
  -v "%cd%:/src" ^
  -w "/src" ^
  ghcr.io/stevehansen/vidyano-frontend-builder:latest
```

---

## 📝 Sample `build-frontend.sh`

Place this at the root of your repo (`.gitattributes` below will enforce LF endings):

```bash
#!/usr/bin/env bash
set -euo pipefail

# enter your frontend folder, if any
cd MyApp/

# install dependencies
npm ci

# compile Sass → CSS
find wwwroot -type f -name "*.scss" -print -execdir sh -c 'sass "{}:${1%.scss}.css"' _ {} \;

# transpile TypeScript
tsc --project ./tsconfig.json

# run any additional build steps
npm run build
```

---

## ⏏️ Enforce LF line endings

Add a `.gitattributes` at your repo root to ensure consistent shell-script line endings:

```gitattributes
*.sh text eol=lf
```

---

## 📦 Publishing

This repository includes a GitHub Actions workflow (`.github/workflows/publish.yml`) that:

1. Builds the `vidyano-frontend-builder:latest` image on each push to `main`.  
2. Pushes `latest` (and a commit‑SHA tag) to GitHub Container Registry.

Use the badge at the top of this README to reflect build status automatically.

---

## 🔄 Extending the Script

- **Custom flags**: pass extra args after the image name, e.g.  
  ```bash
  docker run --rm -v "$(pwd):/src" -w /src ghcr.io/... --prod
  ```
  and read them in your `build-frontend.sh` via `$1`, `$2`, etc.

- **Caching**: if you later want to speed up `npm ci`, you can mount a Docker volume for `~/.npm` (not shown above).

---

That’s it—your entire front‑end build is now a single Docker pull + run!
