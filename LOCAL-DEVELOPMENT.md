# Local development and preview

Develop and preview the KITS College theme locally. Deploy to the VPS when ready.

---

## 1. Quick static preview (no WordPress, no database)

Preview the theme layout and styles using the static mockup. Must be served from the **repo root** so CSS paths work.

**Option A – one command (PowerShell):**

```powershell
cd D:\Work\AmanCollege
.\start-local-preview.ps1
```

Your browser will open **http://localhost:5050/local-preview/** (Aman College mockup).

**Option B – manual:**

```powershell
cd D:\Work\AmanCollege
npx serve .
```

Then open **http://localhost:5050/local-preview/** in your browser.

**Other servers (if you don’t use Node):**

- **PHP:** `php -S localhost:8080` → http://localhost:8080/local-preview/
- **Python:** `python -m http.server 8080` → http://localhost:8080/local-preview/

This is a static mockup (header, hero, sections, footer). To edit the real theme, change files in **wp-content/themes/kits-college/** and refresh; the mockup uses **style.css** from that theme.

---

## 2. Full local WordPress (optional)

To run WordPress locally with the KITS College theme (admin, pages, real content):

1. Install a local stack, e.g.:
   - **[Local](https://localwp.com/)** (by Flywheel) – simple, one-click WordPress sites.
   - **XAMPP** or **Laragon** – PHP + MySQL + Apache/Nginx.
2. Create a new WordPress site (e.g. `aman.local`).
3. Copy the theme into the local WordPress:
   - Copy **D:\Work\AmanCollege\wp-content\themes\kits-college**  
   - To **&lt;local-wp&gt;\wp-content\themes\kits-college**.
4. In WP Admin → **Appearance → Themes**, activate **KITS College**.
5. Add pages and content using [content-migration/CONTENT-MIGRATION.md](content-migration/CONTENT-MIGRATION.md).

You can develop and edit the theme in **D:\Work\AmanCollege\wp-content\themes\kits-college** and sync the folder to your local WordPress when you want to test, or use symlinks if your stack supports them.

---

## 3. What to edit locally

| What | Where |
|------|--------|
| Theme styles | **wp-content/themes/kits-college/style.css** |
| Theme templates | **wp-content/themes/kits-college/*.php** and **template-parts/** |
| Static preview HTML | **local-preview/index.html** (optional; for quick layout tweaks) |
| Content copy | **content-migration/** (paste into WordPress pages when ready) |

Design reference: [Figma KITS College prototype](https://www.figma.com/proto/0I4M2dvF6T7h95XLfjMqW7/KITS-College).

---

## 4. Deploy later

When you’re ready to put the site on the VPS:

- See **[deployment/DEPLOY-RUN.md](deployment/DEPLOY-RUN.md)** – run `.\deployment\deploy.ps1` and follow the steps.
- Content: **[content-migration/CONTENT-MIGRATION.md](content-migration/CONTENT-MIGRATION.md)** – create pages and paste content in WP Admin (locally or on the server).
