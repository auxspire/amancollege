/**
 * Vercel build: output static site at root of `out/` so no rewrites are needed.
 * - Pages at out/index.html, out/about.html, ... (from local-preview)
 * - Assets at out/wp-content, out/Website Old so ../ paths in HTML resolve
 */
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const out = path.join(root, 'public');

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const name of fs.readdirSync(src)) {
    const srcPath = path.join(src, name);
    const destPath = path.join(dest, name);
    if (fs.statSync(srcPath).isDirectory()) {
      copyDir(srcPath, destPath);
    } else {
      fs.mkdirSync(path.dirname(destPath), { recursive: true });
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

if (fs.existsSync(out)) fs.rmSync(out, { recursive: true });
fs.mkdirSync(out, { recursive: true });

// Pages at deployment root: /index.html, /about.html, etc.
copyDir(path.join(root, 'local-preview'), out);

// Assets: ../wp-content and ../Website Old from pages resolve to these
copyDir(path.join(root, 'wp-content'), path.join(out, 'wp-content'));
copyDir(path.join(root, 'Website Old'), path.join(out, 'Website Old'));

console.log('Vercel build done: public/ (pages at root, assets in wp-content & Website Old)');
