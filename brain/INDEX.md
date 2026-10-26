# INDEX — where everything lives
Top level is exactly: brain/ work/ files/ tools/ archive/ (+ README.md, LICENSE, .gitignore, .github/).

## brain/ — memory (5 files + log/ + check.sh)
- CHARTER, RULES, NOW, LESSONS, INDEX; check.sh guards the brain and layout (run after edits)

## brain/log/ — brain/log/YYYY-MM-DD.md, timestamped activity log
- Format, one line per entry: `- HH:MM ET [bot] what happened`
- Append-only, newest at bottom

## work/ — one folder per project
- Example: work/homepage-redesign/

## files/ — raw inputs by literal type
- Example: files/logos/, files/screenshots/, files/research/
- files/uploads/ + files/downloads/ are drop zones: sort within 24h

## tools/ — scripts
## archive/ — old stuff, not read by default

## Filing rules
1. Every file has exactly one home. If unsure, put it in the closest existing folder and add a line here.
2. Names are literal kebab-case: apple-logo.png, not IMG_1234.png.
3. Never create new note files. Rules → RULES.md, priorities → NOW.md, lessons → LESSONS.md.
4. New project? New folder under work/ plus one line in this file.
5. Done with something? Move it to archive/. Don't delete.
