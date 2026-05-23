#!/usr/bin/env bash
set -euo pipefail

useradd -u 1000 -m -s /bin/bash kiosk
usermod -aG wheel,audio,video kiosk
passwd -d kiosk

cat > /etc/sudoers.d/kiosk <<'EOF'
kiosk ALL=(ALL) NOPASSWD: /usr/bin/systemctl poweroff, /usr/bin/systemctl reboot
EOF
chmod 0440 /etc/sudoers.d/kiosk

mkdir -p /var/lib/AccountsService/users
cat > /var/lib/AccountsService/users/kiosk <<'ACCOUNTS'
[User]
Session=kiosk
SystemAccount=false
ACCOUNTS
