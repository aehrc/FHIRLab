#!/usr/bin/env bash
# Generate PDF from the cost estimate README.md
# Requires: pandoc, xelatex, plantuml, python3 + matplotlib
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "==> Regenerating plots..."
python3 generate_plots.py

echo "==> Rendering PlantUML diagrams..."
# Extract plantuml blocks from README.md, render to PNG, and produce a
# modified markdown with image references instead of code blocks.
python3 - <<'PYEOF'
import re, subprocess, os

with open("README.md") as f:
    content = f.read()

counter = 0
def replace_plantuml(match):
    global counter
    counter += 1
    name = f"plantuml_{counter}.png"
    puml = match.group(1)
    with open(f"plantuml_{counter}.puml", "w") as f:
        f.write(puml)
    subprocess.run(["plantuml", "-tpng", "-SbackgroundColor=transparent",
                    f"plantuml_{counter}.puml"], check=True)
    os.remove(f"plantuml_{counter}.puml")
    return f"![](plantuml_{counter}.png)"

modified = re.sub(r'```plantuml\n(.*?)```', replace_plantuml, content, flags=re.DOTALL)

with open("_build.md", "w") as f:
    f.write(modified)

print(f"  Rendered {counter} PlantUML diagrams")
PYEOF

echo "==> Generating PDF..."
pandoc _build.md \
  -o cost-estimate.pdf \
  --pdf-engine=xelatex \
  -V geometry:margin=2.5cm \
  -V fontsize=11pt \
  -V colorlinks=true \
  -V linkcolor=blue \
  -V urlcolor=blue \
  -V mainfont="DejaVu Sans" \
  -V monofont="DejaVu Sans Mono" \
  --highlight-style=tango

rm -f _build.md plantuml_*.png

echo "==> Done: $SCRIPT_DIR/cost-estimate.pdf"
