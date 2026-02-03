# Content Migration: Website Old → WordPress (aman.auxspire.com)

Copy content from `Website Old` into WordPress to match the new KITS College template. Use the [Figma KITS College prototype](https://www.figma.com/proto/0I4M2dvF6T7h95XLfjMqW7/KITS-College) for layout reference.

**Local preview:** The `local-preview/` folder now contains a full static site built from all Website Old content and styled with the KITS College theme (Figma-aligned). Run `.\start-local-preview.ps1` to view it. Use this as the content and structure reference when migrating to WordPress.

**Logo:** The ACST shield logo (LEARNER TO LEADER) is in `Website Old/logo.png` and is used in the header and footer of all local-preview pages.

---

## Page mapping

| Old file | WordPress page (slug) | Page template |
|----------|------------------------|---------------|
| index.php.html / index.htm | Home (front page) | — (set as static front page) |
| about.php.html | About | About |
| course.php.html | Courses | Courses |
| faculties.php.html | Faculties | Faculties |
| fee-structure.php.html | Fee Structure | Default |
| gallery.php.html | Gallery | Gallery |
| contact.php.html | Contact | Contact |
| grievance-redressal.php.html | Grievance Redressal | Grievance Redressal |

---

## Steps

### 1. Media

- Upload all images and PDFs from `Website Old` to **Media → Library**.
- Key files: `logo.png`, `about-banner.jpg`, `about-page.png`, `about-college.jpg`, `course-1.jpg`, `bca.jpg`, `course-3.jpg`, `taxation.jpg`, `ba-english-triple-main.jpg`, `ma-english.jpg`, `bba.jpg`, `computer-science.jpg`, `Mandatory-Disclosure.pdf`, and all `th_*.jpg` (gallery thumbnails).

### 2. Create pages

In **Pages → Add New** (or Edit for each):

- **Home**: Title "Home". Set as **Settings → Reading → A static page → Homepage**.
- **About**: Title "About Us", slug `about`, Template "About". Paste content from `content-migration/about-content.md`.
- **Courses**: Title "Courses", slug `courses`, Template "Courses". Paste content from `content-migration/courses-content.md` or build with blocks; use uploaded course images.
- **Faculties**: Title "Faculties", slug `faculties`, Template "Faculties". Paste from old faculties page body.
- **Fee Structure**: Title "Fee Structure", slug `fee-structure`. Paste table/content from `fee-structure.php.html` (or use a table block).
- **Gallery**: Title "Gallery", slug `gallery`, Template "Gallery". Add gallery block and select uploaded `th_*.jpg` images.
- **Contact**: Title "Contact Us", slug `contact`, Template "Contact". Paste contact info from `content-migration/contact-content.md`.
- **Grievance Redressal**: Title "Grievance Redressal", slug `grievance-redressal`, Template "Grievance Redressal". Paste from old grievance page.

### 3. Menus

- **Appearance → Menus**: Create menu "Primary Menu", add links: Home, About Us, Courses, Faculties, Fee Structure, Gallery, Contact Us. Assign to **Primary Menu**.
- Create "Footer Menu" with Quick Links / Academics as in old site; assign to **Footer Menu**.

### 4. Site identity

- **Appearance → Customize → Site Identity**: Upload `logo.png` as Custom Logo. Set Site Title "Aman College" (or "Aman College of Science & Technology") and Tagline.

---

## Extracted content

See the `content-migration/` folder:

- `about-content.md` — About Us body text
- `courses-content.md` — Courses list and image mapping
- `contact-content.md` — Contact info and address
- `home-tagline.md` — Suggested home hero text

Replace any `[email protected]` with the real contact email if different.
