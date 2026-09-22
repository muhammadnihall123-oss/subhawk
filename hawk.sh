#!/usr/bin/env bash

# ============================================================
#                     🦅 SUBHAWK 🦅
#               SUBDOMAIN DISCOVERY TOOL
# ============================================================

# -------------------- COLORS --------------------

BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
MAGENTA='\033[95m'
CYAN='\033[96m'
WHITE='\033[97m'

# -------------------- TERMINAL --------------------

clear

trap 'echo -e "\n${RED}${BOLD}[!] Scan interrupted.${RESET}"; exit 130' INT

# ============================================================
#                       SUBHAWK BANNER
# ============================================================

echo -e "${CYAN}${BOLD}"

cat << 'EOF'
███████╗██╗   ██╗██████╗ ██╗  ██╗ █████╗ ██╗    ██╗██╗  ██╗
██╔════╝██║   ██║██╔══██╗██║  ██║██╔══██╗██║    ██║██║ ██╔╝
███████╗██║   ██║██████╔╝███████║███████║██║ █╗ ██║█████╔╝
╚════██║██║   ██║██╔══██╗██╔══██║██╔══██║██║███╗██║██╔═██╗
███████║╚██████╔╝██████╔╝██║  ██║██║  ██║╚███╔███╔╝██║  ██╗
╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝
EOF

echo -e "${RESET}"

echo -e "${MAGENTA}${BOLD}"
echo "                         🦅 SUBHAWK 🦅"
echo -e "${RESET}"

echo -e "${YELLOW}${BOLD}"
echo "                 SUBDOMAIN DISCOVERY TOOL"
echo -e "${RESET}"

echo -e "${BLUE}${BOLD}"
echo "════════════════════════════════════════════════════════════════════════════════════"
echo -e "${RESET}"

# ============================================================
#                    DEPENDENCY CHECK
# ============================================================

if ! command -v assetfinder >/dev/null 2>&1; then
    echo -e "${RED}${BOLD}[✗] assetfinder is not installed or not in PATH.${RESET}"
    echo
    echo -e "${YELLOW}Please install assetfinder before running SUBHAWK.${RESET}"
    echo -e "${WHITE}Tool: assetfinder${RESET}"
    exit 1
fi

echo -e "${GREEN}${BOLD}[✓] assetfinder detected${RESET}"

# ============================================================
#                      DOMAIN INPUT
# ============================================================

echo
echo -ne "${MAGENTA}${BOLD}[?] ENTER TARGET DOMAIN → ${RESET}"
read -r DOMAIN

# Remove protocol
DOMAIN="${DOMAIN#http://}"
DOMAIN="${DOMAIN#https://}"

# Remove path
DOMAIN="${DOMAIN%%/*}"

# Remove trailing dot
DOMAIN="${DOMAIN%.}"

# Convert to lowercase
DOMAIN="${DOMAIN,,}"

# ============================================================
#                       VALIDATION
# ============================================================

if [[ -z "$DOMAIN" ]]; then
    echo -e "${RED}${BOLD}[✗] No domain entered.${RESET}"
    exit 1
fi

if [[ ! "$DOMAIN" =~ ^([a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?)$ ]]; then
    echo -e "${RED}${BOLD}[✗] Invalid domain: $DOMAIN${RESET}"
    exit 1
fi

# ============================================================
#                     OUTPUT DIRECTORY
# ============================================================

OUTPUT_DIR="results"

mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
OUTPUT_FILE="${OUTPUT_DIR}/${DOMAIN}_${TIMESTAMP}.txt"

# ============================================================
#                       SCAN DETAILS
# ============================================================

echo
echo -e "${CYAN}${BOLD}"
echo "┌────────────────────────────────────────────────────────────────────────────────────┐"
echo "│                              SCAN INFORMATION                                      │"
echo "├────────────────────────────────────────────────────────────────────────────────────┤"
echo -e "│  ${WHITE}Target      :${RESET} ${GREEN}${DOMAIN}${CYAN}                                             │"
echo -e "│  ${WHITE}Engine      :${RESET} ${YELLOW}assetfinder${CYAN}                                         │"
echo -e "│  ${WHITE}Output      :${RESET} ${MAGENTA}${OUTPUT_FILE}${CYAN}              │"
echo -e "│  ${WHITE}Started     :${RESET} ${DIM}$(date '+%Y-%m-%d %H:%M:%S')${CYAN}                                │"
echo "└────────────────────────────────────────────────────────────────────────────────────┘"
echo -e "${RESET}"

# ============================================================
#                         SCANNING
# ============================================================

START_TIME=$(date +%s)

echo
echo -ne "${YELLOW}${BOLD}[~] SUBHAWK IS HUNTING"

for _ in {1..6}; do
    sleep 0.2
    echo -ne "."
done

echo -e "${RESET}"
echo

TEMP_FILE=$(mktemp)

if ! assetfinder --subs-only "$DOMAIN" 2>/dev/null > "$TEMP_FILE"; then
    rm -f "$TEMP_FILE"

    echo -e "${RED}${BOLD}[✗] assetfinder failed.${RESET}"
    exit 1
fi

# Sort and remove duplicates
sort -u "$TEMP_FILE" | sed '/^[[:space:]]*$/d' > "$OUTPUT_FILE"

rm -f "$TEMP_FILE"

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

# ============================================================
#                       RESULT CHECK
# ============================================================

if [[ ! -s "$OUTPUT_FILE" ]]; then

    echo
    echo -e "${RED}${BOLD}[✗] No subdomains discovered.${RESET}"

    rm -f "$OUTPUT_FILE"

    exit 0
fi

COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')

# ============================================================
#                     DISCOVERED HOSTS
# ============================================================

echo -e "${GREEN}${BOLD}"
echo "╔════════════════════════════════════════════════════════════════════════════════════╗"
echo "║                              🦅 DISCOVERED HOSTS 🦅                              ║"
echo "╚════════════════════════════════════════════════════════════════════════════════════╝"
echo -e "${RESET}"

INDEX=1

while IFS= read -r SUBDOMAIN; do

    # Alternate colors
    if (( INDEX % 2 == 0 )); then
        COLOR="$CYAN"
    else
        COLOR="$WHITE"
    fi

    printf "  ${GREEN}${BOLD}%4d${RESET} ${MAGENTA}➜${RESET} ${COLOR}%s${RESET}\n" \
        "$INDEX" "$SUBDOMAIN"

    ((INDEX++))

done < "$OUTPUT_FILE"

# ============================================================
#                         SUMMARY
# ============================================================

echo

echo -e "${MAGENTA}${BOLD}"
echo "════════════════════════════════════════════════════════════════════════════════════"
echo -e "${RESET}"

echo -e "${GREEN}${BOLD}"
echo "                         🦅 SUBHAWK FINISHED"
echo -e "${RESET}"

echo
echo -e "${WHITE}${BOLD}  TARGET          :${RESET} ${CYAN}${DOMAIN}${RESET}"
echo -e "${WHITE}${BOLD}  SUBDOMAINS      :${RESET} ${GREEN}${COUNT}${RESET}"
echo -e "${WHITE}${BOLD}  TIME TAKEN      :${RESET} ${YELLOW}${ELAPSED}s${RESET}"
echo -e "${WHITE}${BOLD}  RESULTS SAVED   :${RESET} ${MAGENTA}${OUTPUT_FILE}${RESET}"

echo

echo -e "${MAGENTA}${BOLD}"
echo "════════════════════════════════════════════════════════════════════════════════════"
echo -e "${RESET}"

echo -e "${CYAN}${BOLD}"
echo "                    🦅 SUBHAWK — KEEP HUNTING 🦅"
echo -e "${RESET}"

echo
