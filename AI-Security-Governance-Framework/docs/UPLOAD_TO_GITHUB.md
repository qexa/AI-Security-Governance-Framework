# Upload to GitHub (Step-by-Step)

## Option A — Upload using the GitHub website
1) Download and unzip the project ZIP.
2) Create a new GitHub repo named `AI-Security-Governance-Framework` (do not initialize with README).
3) In GitHub: Add file → Upload files.
4) Upload the **contents** of the unzipped folder (avoid double-nesting).
5) Commit changes.
6) Go to Actions and confirm workflows run.

## Option B — Upload using Git (recommended)
From the folder that contains `README.md`:

```bash
git init
git add .
git commit -m "Initial commit: AI Security Governance Framework"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/AI-Security-Governance-Framework.git
git push -u origin main
```

## Option C — Upload using GitHub CLI (gh)
```bash
gh auth login
cd AI-Security-Governance-Framework
git init
git add .
git commit -m "Initial commit: AI Security Governance Framework"
gh repo create AI-Security-Governance-Framework --public --source=. --remote=origin --push
```

## After Upload (Quick Validation)
- Confirm `.github/workflows/ai-security-scan.yml` exists.
- Go to Actions → open a run → download Artifacts:
  - `evidence-terraform-and-iac-<run_id>`
  - `evidence-redteam-<run_id>`
