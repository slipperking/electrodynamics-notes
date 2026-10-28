---
name: patched-typst-site-build
description: Build and validate this reusable Typst publishing repository with its patched compiler and project-specific site modes. Use for source, layout, reference, or build changes in repositories retaining this infrastructure.
---

# Patched Typst Site Build

Use the repository-local `./typst.exe`; this publishing infrastructure depends on its raised convergence limit and selector-target support. Do not substitute a system Typst binary for validation.

For ordinary subject-content, prose, equation, and local layout changes, prefer the fast HTML-only debug bundle:

```powershell
./typst.exe compile --features bundle,html --format bundle --package-path packages --font-path src/assets/fonts --input html-only=true --input debug-build=true main.typ dist
```

This skips canvas-generated drawings, the theorem and figure lists, and the downloadable PDF. A canvas needed for a focused check can opt back in with `debug-show: true`.

Treat `debug-show` as a user-controlled source preference. Preserve every existing `debug-show` setting exactly as written unless the user explicitly asks to change it; a production build, emitted todo, or pre-push convention is not authorization to remove or disable it.

Use the non-debug or combined-output build when changing publishing infrastructure, cross-output routing, references, generated pages/assets, figures, or PDF behavior, or when the user requests production verification:

```powershell
./typst.exe compile --features bundle,html --format bundle --package-path packages --font-path src/assets/fonts main.typ dist
```

Run preprocessing first only when generated visual data is affected:

```powershell
python scripts/build.py
```

Run search-index generation after a bundle build only when search assets/indexing or final production output is in scope:

```powershell
python build-search-index.py
```

For CetZ diagrams, follow the repository's established annotation convention: wrap mathematical labels passed to `content(...)` in `math-rect(...)`. This gives labels a lightly backed, consistent treatment and keeps geometry from showing through the text.

For a PDF-only check, use the local executable with the legacy routing input:

```powershell
./typst.exe compile --features bundle,html --package-path packages --font-path src/assets/fonts --input legacy-label-routing=true main.typ
```
