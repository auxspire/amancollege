/**
 * Vercel build: copy static site and assets into `out/` so Output Directory = "out" works.
 * Keeps local-preview, wp-content, and Website Old so asset paths (../wp-content, ../Website Old) resolve.
 */
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const out = path.join(root, 'out');

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

copyDir(path.join(root, 'local-preview'), path.join(out, 'local-preview'));
copyDir(path.join(root, 'wp-content'), path.join(out, 'wp-content'));
copyDir(path.join(root, 'Website Old'), path.join(out, 'Website Old'));

const redirectHtml = `<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="refresh" content="0;url=/local-preview/">
  <title>Redirecting – Aman College</title>
</head>
<body>
  <p>Redirecting to <a href="/local-preview/">Aman College</a>…</p>
</body>
</html>
`;
fs.writeFileSync(path.join(out, 'index.html'), redirectHtml, 'utf8');

console.log('Vercel build done: out/');
