// restructure.js
const fs = require('fs').promises;
const path = require('path');
const cheerio = require('cheerio');

async function createDirectoryStructure(baseDir) {
    const dirs = [
        'assets/css',
        'assets/js',
        'assets/images',
        '_includes',
    ];

    for (const dir of dirs) {
        await fs.mkdir(path.join(baseDir, dir), { recursive: true });
    }
}

async function extractStyles(html) {
    const $ = cheerio.load(html);
    let styles = '';
    
    // Extract inline styles
    $('style').each((i, elem) => {
        styles += $(elem).html() + '\n';
    });
    
    // Extract and update stylesheet links
    $('link[rel="stylesheet"]').each((i, elem) => {
        const href = $(elem).attr('href');
        if (href && href.includes('wp-content')) {
            $(elem).attr('href', '/assets/css/wp-content.css');
        }
    });
    
    // Remove inline styles
    $('style').remove();
    
    return {
        styles,
        updatedHtml: $.html()
    };
}

async function extractScripts(html) {
    const $ = cheerio.load(html);
    let scripts = '';
    
    // Extract inline scripts
    $('script:not([src])').each((i, elem) => {
        scripts += $(elem).html() + '\n';
    });
    
    // Update script sources
    $('script[src]').each((i, elem) => {
        const src = $(elem).attr('src');
        if (src && src.includes('wp-content')) {
            $(elem).attr('src', '/assets/js/wp-content.js');
        }
    });
    
    // Remove inline scripts
    $('script:not([src])').remove();
    
    return {
        scripts,
        updatedHtml: $.html()
    };
}

async function extractNavigation(html) {
    const $ = cheerio.load(html);
    const nav = $('.navbar-primary').html() || '';
    $('.navbar-primary').replaceWith('<!-- include navigation.html -->');
    return {
        nav,
        updatedHtml: $.html()
    };
}

async function extractFooter(html) {
    const $ = cheerio.load(html);
    const footer = $('.site-footer').html() || '';
    $('.site-footer').replaceWith('<!-- include footer.html -->');
    return {
        footer,
        updatedHtml: $.html()
    };
}

async function restructureSite(sourcePath, outputPath) {
    try {
        // Create directory structure
        await createDirectoryStructure(outputPath);
        
        // Read source index.html
        const html = await fs.readFile(sourcePath, 'utf8');
        
        // Extract components
        const { styles, updatedHtml: html1 } = await extractStyles(html);
        const { scripts, updatedHtml: html2 } = await extractScripts(html1);
        const { nav, updatedHtml: html3 } = await extractNavigation(html2);
        const { footer, updatedHtml: finalHtml } = await extractFooter(html3);
        
        // Write files
        await Promise.all([
            fs.writeFile(path.join(outputPath, 'index.html'), finalHtml),
            fs.writeFile(path.join(outputPath, 'assets/css/main.css'), styles),
            fs.writeFile(path.join(outputPath, 'assets/js/main.js'), scripts),
            fs.writeFile(path.join(outputPath, '_includes/navigation.html'), nav),
            fs.writeFile(path.join(outputPath, '_includes/footer.html'), footer),
        ]);
        
        console.log('Site restructured successfully!');
        
    } catch (error) {
        console.error('Error restructuring site:', error);
    }
}

// Usage
const sourceDir = process.argv[2] || '.';
const outputDir = process.argv[3] || './restructured';

restructureSite(
    path.join(sourceDir, 'index.html'),
    outputDir
);