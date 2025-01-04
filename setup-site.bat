@echo off
REM Create directories
mkdir assets
mkdir assets\css
mkdir assets\images

REM Create style.css
echo :root { > assets\css\style.css
echo     --dark-bg: #121212; >> assets\css\style.css
echo     --header-bg: rgba(0, 0, 0, 0.9); >> assets\css\style.css
echo     --text-color: #ffffff; >> assets\css\style.css
echo     --link-hover: #4a90e2; >> assets\css\style.css
echo     --nav-spacing: 2rem; >> assets\css\style.css
echo } >> assets\css\style.css
REM ... rest of style.css content

REM Create water-effect.css
echo .water-effect-container { > assets\css\water-effect.css
echo     position: fixed; >> assets\css\water-effect.css
echo     top: 0; >> assets\css\water-effect.css
echo     left: 0; >> assets\css\water-effect.css
echo     width: 100%%; >> assets\css\water-effect.css
echo     height: 100%%; >> assets\css\water-effect.css
echo     z-index: 1; >> assets\css\water-effect.css
echo     pointer-events: none; >> assets\css\water-effect.css
echo } >> assets\css\water-effect.css
REM ... rest of water-effect.css content

REM Create water-effect.svg
echo ^<?xml version="1.0" encoding="UTF-8"?^> > assets\images\water-effect.svg
echo ^<svg viewBox="0 0 1600 200" xmlns="http://www.w3.org/2000/svg"^> >> assets\images\water-effect.svg
echo   ^<defs^> >> assets\images\water-effect.svg
REM ... rest of SVG content

echo Setup complete!
pause