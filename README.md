# Aman College – WordPress CMS (aman.auxspire.com)

WordPress site for Aman College. Custom theme (KITS College) and content from the old static site. **Develop and preview locally; deploy to the VPS when ready.**

## Repository structure

| Path | Purpose |
|-----|---------|
| **wp-content/themes/kits-college/** | Custom WordPress theme (KITS College) |
| **local-preview/** | Static mockup to preview theme locally (no WordPress) |
| **content-migration/** | Extracted content and migration guide (Website Old → WordPress) |
| **deployment/** | VPS setup and deploy scripts (use when you deploy) |
| **Website Old/** | Original static site files (content source) |

## Local development and preview

1. **Preview the theme (no WordPress):** From the repo root run  
   `.\start-local-preview.ps1`  
   Your browser will open the static mockup. See [LOCAL-DEVELOPMENT.md](LOCAL-DEVELOPMENT.md).
2. **Edit the theme:** Change files in **wp-content/themes/kits-college/** (e.g. `style.css`, templates in `template-parts/`). Refresh the local preview to see updates.
3. **Content:** Use [content-migration/CONTENT-MIGRATION.md](content-migration/CONTENT-MIGRATION.md) when you add pages (locally or on the server).
4. **Design reference:** [Figma KITS College prototype](https://www.figma.com/proto/0I4M2dvF6T7h95XLfjMqW7/KITS-College).

## Deploy to VPS later

When you’re ready to put the site on the server:

- Run `.\deployment\deploy.ps1` (see [deployment/DEPLOY-RUN.md](deployment/DEPLOY-RUN.md)).
- Finish WordPress install on the VPS; activate **KITS College**; add content.

VPS: **72.61.227.53** · Site URL after deploy: **http://72.61.227.53:8080** · Details: [deployment/](deployment/).
