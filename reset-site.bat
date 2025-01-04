@echo off
echo Cleaning up old files...
del /q assets\css\style.css
del /q assets\css\water-effect.css
del /q assets\images\water-effect.svg

echo Creating CSS files...
powershell -Command "(Get-Content assets.txt -Raw) -replace '\$\{([^}]+)\}','$1' | Set-Content assets\css\style.css"
powershell -Command "(Get-Content water-effect.txt -Raw) -replace '\$\{([^}]+)\}','$1' | Set-Content assets\css\water-effect.css"
powershell -Command "(Get-Content svg.txt -Raw) -replace '\$\{([^}]+)\}','$1' | Set-Content assets\images\water-effect.svg"

echo Done! Files have been reset and recreated.
echo.
git add .
git commit -m "Reset and update site styling"
git push origin main
pause