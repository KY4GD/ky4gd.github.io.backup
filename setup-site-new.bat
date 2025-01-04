@echo off
echo Creating new directories...
mkdir site-new\assets\css
mkdir site-new\assets\images

echo Creating new style.css...
(
echo /* Main Styles */
echo :root {
echo     --dark-bg: #121212;
echo     --header-bg: rgba(0, 0, 0, 0.9^);
echo     --text-color: #ffffff;
echo     --link-hover: #4a90e2;
echo     --nav-spacing: 2rem;
echo }
REM ... rest of the full CSS content
) > site-new\assets\css\style.css