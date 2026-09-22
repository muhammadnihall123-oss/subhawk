# subhawk# 🦅 SUBHAWK

### 🌈 Colorful Subdomain Discovery Tool

**SUBHAWK** is a lightweight Bash-based subdomain discovery tool that uses
[`assetfinder`](https://github.com/tomnomnom/assetfinder) to discover subdomains
for a target domain and display them in a colorful, clean terminal interface.

> ⚠️ **Disclaimer:** SUBHAWK is intended for authorized security testing,
> reconnaissance, and educational purposes only. Only scan domains that you
> own or have explicit permission to assess.

---

## ✨ Features

- 🦅 Large SUBHAWK ASCII banner
- 🌈 Bright ANSI terminal colors
- 🔎 Subdomain discovery using `assetfinder`
- 🧹 Automatically removes duplicate results
- 🔢 Numbers discovered subdomains
- 💾 Automatically saves results to a `results/` directory
- ⏱️ Displays scan duration
- 🛑 Handles `Ctrl+C` gracefully
- ✅ Checks whether `assetfinder` is installed
- 🌐 Accepts domains with or without `http://` / `https://`

---

## 📋 Requirements

Before using SUBHAWK, make sure you have:

- Linux, macOS, or another Unix-like environment
- Bash
- `assetfinder`

Check whether Bash is available:

```bash
bash --version


Check whether assetfinder is installed:

assetfinder --help

⚙️ Installation

Clone the repository:

git clone https://github.com/YOUR-USERNAME/subhawk.git


Enter the project directory:

cd subhawk


Make the script executable:

chmod +x script.sh

🛠️ Installing Assetfinder

Install assetfinder using Go:

go install github.com/tomnomnom/assetfinder@latest


Verify the installation:

assetfinder --help


If your system cannot find assetfinder, make sure your Go binary
directory is included in your PATH.

🚀 Usage

Run SUBHAWK:

./script.sh


You will be prompted to enter a domain:

[?] ENTER TARGET DOMAIN → example.com


SUBHAWK will then discover available subdomains and display them in
the terminal.

📂 Output

Results are automatically saved inside the results/ directory.

Example:

subhawk/
├── script.sh
├── README.md
└── results/
    └── example.com_20260918_110500.txt


A results file may contain:

api.example.com
dev.example.com
mail.example.com
portal.example.com
www.example.com


Results are sorted and duplicate entries are removed.

🎨 Terminal Interface

SUBHAWK provides a colorful terminal interface with:

🦅 SUBHAWK
SUBDOMAIN DISCOVERY TOOL

[✓] assetfinder detected

[?] ENTER TARGET DOMAIN → example.com

[~] SUBHAWK IS HUNTING......

╔════════════════════════════════════════════════════════════════╗
║                    🦅 DISCOVERED HOSTS 🦅                    ║
╚════════════════════════════════════════════════════════════════╝

     1 ➜ api.example.com
     2 ➜ dev.example.com
     3 ➜ mail.example.com
     4 ➜ portal.example.com

════════════════════════════════════════════════════════════════

                         🦅 SUBHAWK FINISHED

  TARGET          : example.com
  SUBDOMAINS      : 4
  TIME TAKEN      : 3s
  RESULTS SAVED   : results/example.com_20260918_110500.txt

🧰 Project Structure
SUBHAWK/
│
├── script.sh
├── README.md
│
└── results/
    └── *.txt

🔐 Responsible Use

SUBHAWK performs passive subdomain discovery through assetfinder.
However, information discovered during reconnaissance can still be
sensitive.

Use SUBHAWK only when:

You own the target domain

You have explicit authorization to test the target

You are performing an authorized security assessment

You are using it in a controlled educational environment

Do not use this tool to perform unauthorized reconnaissance against
systems you do not have permission to assess.

🤝 Contributing

Contributions are welcome.

To contribute:

git fork


Create a feature branch:

git checkout -b feature/my-feature


Make your changes and commit them:

git add .
git commit -m "Add new feature"


Push your branch:

git push origin feature/my-feature


Then open a Pull Request.

🐛 Issues

If you encounter a bug or have a feature request, open an issue in the
GitHub repository.

When reporting a problem, include:

Operating system

Bash version

Assetfinder version

Error message

Steps to reproduce the issue

Do not include sensitive target information.

📜 License

Choose a license appropriate for your project.

For example, if you use the MIT License, add a LICENSE file containing
the MIT license text.

🦅 SUBHAWK

Lightweight. Colorful. Simple.

        🦅
       /  \
      /    \
     / SUB  \
    /  HAWK  \
   /__________\

  SUBDOMAIN DISCOVERY TOOL

⭐ If you find SUBHAWK useful, consider starring the repository!
:::
