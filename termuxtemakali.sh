#!/bin/bash

# Hentikan skrip jika ada error
set -e

echo "🚀 Memulai setup otomatis Fish Shell ala Kali Linux..."
sleep 2

# 1. Update & Instalasi Paket
echo -e "\n[1/7] Memperbarui package list..."
pkg update -y
echo -e "\n[2/7] Menginstal package yang dibutuhkan (fish, neofetch, git, curl)..."
pkg install fish neofetch git curl -y

# 2. Instalasi Nerd Font
echo -e "\n[3/7] Mengunduh dan menginstal Nerd Font (FiraCode)..."
mkdir -p ~/.termux
curl -fLo ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf

# 3. Membuat Direktori Konfigurasi Fish
echo -e "\n[4/7] Membuat direktori konfigurasi untuk Fish..."
mkdir -p ~/.config/fish/functions

# 4. Membuat Fungsi fish_prompt
echo -e "\n[5/7] Menulis konfigurasi prompt kustom..."
cat << 'EOF' > ~/.config/fish/functions/fish_prompt.fish
function fish_prompt
    set -l last_status $status
    set -l prompt_color green
    set -l info_color brblue
    set -l path_color normal --bold
    if test (id -u) -eq 0
        set prompt_color brblue
        set info_color brred
    end
    set_color $prompt_color
    printf '┌──'
    printf '('
    set_color $info_color
    printf '%s㉿%s' (whoami) (hostname)
    set_color $prompt_color
    printf ')'
    printf '-['
    set_color $path_color
    printf '%s' (prompt_pwd)
    set_color $prompt_color
    printf ']'
    printf '\n'
    printf '└─'
    set_color $info_color
    if test (id -u) -eq 0
        printf '# '
    else
        printf '$ '
    end
    set_color normal
end
EOF

# 5. Membuat Fungsi fish_greeting
echo -e "\n[6/7] Mengatur Neofetch sebagai pesan selamat datang..."
cat << 'EOF' > ~/.config/fish/functions/fish_greeting.fish
function fish_greeting
    neofetch --ascii_distro kali
end
EOF

# 6. Finalisasi
echo -e "\n[7/7] Menghilangkan pesan default Termux dan mengatur Fish sebagai shell utama..."
touch ~/.hushlogin
chsh -s fish

# 7. Selesai
echo -e "\n\n✅ Sempurna! Setup otomatis telah berhasil."
echo "======================================================"
echo "PENTING: Silakan TUTUP PAKSA (FORCE CLOSE) aplikasi Termux"
echo "dan buka kembali untuk melihat hasil akhirnya."
echo "======================================================"