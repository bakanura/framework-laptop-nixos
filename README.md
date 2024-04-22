# NixOS Configuration for the Framework 13 AMD series laptop

Welcome to your NixOS system configuration! This file is where you define what gets installed and how your system behaves. Below is a breakdown of various settings and options you can tweak.

## Bootloader

- **Systemd-boot:** Enabled
- **Touch EFI Variables:** Enabled

## Networking

- **Hostname:** nixos
- **NetworkManager:** Enabled

## Time and Locale

- **Time Zone:** Europe/Berlin
- **Locale:** en_US.UTF-8 with additional settings for de_DE.UTF-8

## Display and Desktop Environment

- **X11 Windowing System:** Enabled
- **GNOME Desktop Environment:** Enabled

## Hardware and Drivers

- **Firmware Updates:** Enabled with LVFS testing (Note: Make sure to update all drivers to the latest version, especially for framework 13)
- **Sound:** Enabled with PipeWire
- **Bluetooth:** Experimental settings enabled

## Programs and Services

- **Print Support:** Enabled with CUPS
- **Touchpad Support:** Enabled
- **Fingerprint Authentication:** Enabled with fprintd
  - Ensure all drivers are updated via fwupd for proper functionality on framework 13
  - avoid using tod drivers
- **Power Management:** Enabled with powertop
- **Thermal Data:** Enabled
- **Steam Integration:** Enabled with hardware support
- **VSCode Extensions:** Included

## User Account

- **Username:** lunchbag
- **Description:** Lunchbag
- **Additional Groups:** networkmanager, wheel
- **Installed Packages:** 
  - Firefox
  - Lutris
  - Wine
  - Discord
  - Steam
  - Thunderbird
  - VSCode
  - Terraform
  - PulseAudio
  - Console mixer (pulsemixer)
  - Equalizer on steroids (easyeffects)
  - LDAC Bluetooth
  - Fingerprint daemon (fprintd)
  - Firmware updates (fwupd)

## System Packages

- Steam
- LDAC Bluetooth
- Fingerprint daemon (fprintd)
- Firmware updates (fwupd)
- VSCode with extensions
- Go
- Terraform
- PulseAudioFull

## Other Configurations

- **Allow Unfree Packages:** Enabled
- **NixOS State Version:** 23.11

Feel free to modify this configuration according to your needs. Don't forget to set a password for the user account and explore more options available in the NixOS manual.
