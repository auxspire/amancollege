# Local preview – KITS College theme

Full static site built from **Website Old** content and styled with the KITS College theme (Figma reference). No WordPress or PHP required.

This preview is kept intentionally close to the WordPress theme: typography and image rules mirror `../wp-content/themes/kits-college/style.css`. Page-specific overrides live in `local-overrides.css` and use only theme variables (`--color-*`, `--font-heading`, `--font-body`, `--radius`, `--shadow`, etc.) so the static site stays a faithful mirror of the WP template.

## Pages

- **index.html** — Home (hero, academics, about, courses, CTA, campus life, contact CTA, footer)
- **about.html** — About Us (university, management, images)
- **courses.html** — Courses by department (Commerce, English, BBA, BCA)
- **contact.html** — Contact info, message form, map
- **fee-structure.html** — Fee table (UG summary)
- **gallery.html** — Gallery grid (campus events)
- **faculties.html** — Departments and faculties
- **grievance.html** — Grievance redressal form

Images and assets are loaded from `../Website Old/`. Styles from `../wp-content/themes/kits-college/style.css` plus `local-overrides.css` (theme variables only, Figma-aligned).

## How to run

From the repo root:

```powershell
.\start-local-preview.ps1
```

Browser opens **http://localhost:5050/local-preview/** (home). Navigate to About, Courses, Contact, etc. Server must run from the **repository root** so paths to theme CSS and Website Old work. See [../LOCAL-DEVELOPMENT.md](../LOCAL-DEVELOPMENT.md) for full local dev and deploy-later steps.
