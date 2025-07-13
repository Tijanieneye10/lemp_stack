#!/bin/bash
set -e

# Set output path
OUTPUT="dist/install.sh"

# Create output directory if it doesn't exist
mkdir -p dist

# Start fresh
> "$OUTPUT"

# Add a header comment (optional)
echo "#!/bin/bash" >> "$OUTPUT"
echo "# Auto-generated install script" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Append each module
cat modules/utils.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"
cat modules/nginx.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"
cat modules/php.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"
cat modules/mysql.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"
cat modules/composer.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"
cat modules/configuration.sh >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Finally, append the main install logic (that used to source the modules)
cat main.sh >> "$OUTPUT"

chmod +x "$OUTPUT"
echo "✅ Built $OUTPUT"