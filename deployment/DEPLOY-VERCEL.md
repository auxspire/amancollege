# Deploy static preview to Vercel

The repo is set up so Vercel serves the **local-preview** static site (theme + content) from the project root.

## After importing the repo in Vercel

1. **Build & Development Settings**
   - **Framework Preset:** Other
   - **Build Command:** `npm run build`
   - **Output Directory:** `public` (the build script writes the static site here)
   - **Install Command:** leave default (`npm install`)

2. **Redeploy**  
   If the first deploy failed, push the latest commit (with `vercel.json` and `package.json`) and trigger a new deployment.

## How it works

- `vercel.json` rewrites `/` and `/about.html`, `/courses.html`, etc. to files under `local-preview/`.
- CSS and images are served from `wp-content/themes/kits-college/` and `Website Old/` at the root, so asset paths in the HTML work.
- The WordPress theme (PHP) is not run on Vercel; only the static preview is deployed.
