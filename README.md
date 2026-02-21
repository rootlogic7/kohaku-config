# 👻 Spirit-OS

A modular, reproducible, and deeply themed NixOS configuration built with Flakes and Home-Manager. 

## 🌌 Architecture
Spirit-OS is designed to be hardware-agnostic at its core, allowing seamless deployment across multiple machines while maintaining a unified, centralized theming engine.

* **Flakes & Home-Manager:** Centralized dotfile and package management.
* **Impermanence (Erase Your Darlings):** Root file systems are mounted on ZFS-snapshots and wiped on every boot. Only strictly defined state is kept in `/persist`.
* **SOPS-Nix:** Age-encrypted secret management for passwords and API keys.
* **Spirit-Theme Engine:** A custom Nix module defining global hex codes and variables (based on Catppuccin), injecting them into all apps (Hyprland, Ghostty, Waybar, etc.).

## 💻 Hosts

* **`kohaku`** (Desktop)
  * High-performance Wayland environment (Hyprland).
  * Dual-monitor setup with gaming-optimized input overrides.
  * ZFS layout with dedicated gaming pools.
  * Uses the `chaotic-nyx` CachyOS kernel for lower latency.
* **`shikigami`** (Laptop - Thinkpad)
  * Lightweight, portable Wayland environment.
  * Intel integrated graphics, touchpad gestures, and single-display layout.
  * Strict impermanence setup for maximum privacy.

## 🛠️ Core Stack
* **WM:** Hyprland
* **Terminal:** Ghostty
* **Shell:** Zsh / Fastfetch
* **Bar/Shell:** Quickshell / Waybar
* **File Manager:** Yazi

## 🚀 Installation (New Host)
1. Boot from a NixOS Live USB.
2. Partition the disk using the host's `disko.nix` script.
3. Generate hardware config: `nixos-generate-config --show-hardware-config`
4. Add the new host to `flake.nix` and create its host directory.
5. Provide the `age` key for SOPS decryption.
6. Run `nixos-rebuild switch --flake .#<hostname>`
