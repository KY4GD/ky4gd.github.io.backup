@echo off
echo Creating all files with correct content...

echo Creating style.css...
(
echo /* Main Styles for 93/93 */
echo :root {
echo     --dark-bg: #121212;
echo     --header-bg: rgba(0, 0, 0, 0.9^);
echo     --text-color: #ffffff;
echo     --link-hover: #4a90e2;
echo     --nav-spacing: 2rem;
echo }
) > assets\css\style.css

echo Creating water-effect.css...
(
echo .water-effect-container {
echo     position: fixed;
echo     top: 0;
echo     left: 0;
echo     width: 100%%;
echo     height: 100%%;
echo     z-index: 1;
echo     pointer-events: none;
echo }
) > assets\css\water-effect.css

echo Creating water-effect.svg...
(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<svg viewBox="0 0 1600 200" xmlns="http://www.w3.org/2000/svg"^>
echo   ^<defs^>
echo     ^<linearGradient id="waterGrad" x1="0%%" y1="0%%" x2="0%%" y2="100%%"^>
echo       ^<stop offset="0%%" style="stop-color:#2c5364;stop-opacity:1" /^>
echo       ^<stop offset="100%%" style="stop-color:#203a43;stop-opacity:1" /^>
echo     ^</linearGradient^>
echo   ^</defs^>
echo   ^<rect width="100%%" height="100%%" fill="url(#waterGrad^)" /^>
echo ^</svg^>
) > assets\images\water-effect.svg

git add .
git commit -m "Fix site styles and water effect"
git push origin main

echo Done! All files created and pushed.
pause