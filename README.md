# CLIMYID

CLIMYID is a simple CLI tool for your server.

![Demo picture](https://cdn.images.my.id/images/2020/04/29/75781d4f2bb85137d8a92549bee7ed0c.png)

## Features
- [x] Update Linux machine (Kali, CentOS, Debian, Ubuntu)
- [x] Install LEMP stack (Nginx, MySQL, PHP 7x) + Fail2ban (Debian, Ubuntu)
- [x] Install Docker Engine (CentOS, Debian, Ubuntu)
- [x] Install Node.js Stack (Node.js + NPM + NGINX) + Fail2ban (CentOS, Debian, Ubuntu)
- [ ] Install LAMP stack (Apache, MySQL, PHP 7x) + Fail2ban

## How to use
```bash
wget -q https://cli.my.id/run.sh && bash run.sh
```

## Live site
https://cli.my.id

## Alternative site

URL | Package | Powered by
---------|---------|----------
 https://cli.ertomedia.net | Stable | [Render](https://cli.onrender.com/)
 https://climyid.netlify.com | Stable | [Netlify](https://climyid.netlify.com/)
 https://climyid.now.sh | Stable | [Vercel](https://climyid.now.sh/)
 https://cli.erto.co | Nightly | [Firebase](https://climyid.web.app/)

## Changelog

Version 0.6:
* [NEW] Install Node.js Stack (Node.js + NPM + NGINX) + Fail2ban
* [NEW] Check IP Whois
* [NEW] Check Website Header
* [NEW] Check RAM allocation
* [NEW] Install Stackdriver Logging & Monitoring
* [FIX] Code optimization.

Version 0.5:
* [NEW] Install WireGuard VPN. Credits to [Nyr](https://github.com/Nyr/wireguard-install).
* [NEW] Install Docker Engine for CentOS, Debian & Ubuntu.
* [FIX] Code optimization.

Version 0.4:
* [NEW] Install LEMP stack (Nginx, MySQL, PHP 7.4) + Fail2ban for Debian & Ubuntu.
* [NEW] Server Benchmark. Credits to [masonr YABS](https://github.com/masonr/yet-another-bench-script).
* [FIX] Code optimization.

Version 0.3:
* [NEW] Automatic distro check for **Update my Linux** menu.
* [NEW] Script for updating Gitea, a self-hosted Git platform.
* [FIX] Code optimization.

Version 0.2:
* [NEW] Update script for Kali.
* [UPDATE] Menu header redesign.

Version 0.1:
* Update script for CentOS.
* Update script for Ubuntu.
* Update script for Debian.
