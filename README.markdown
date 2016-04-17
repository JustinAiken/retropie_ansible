# RetroPi Ansible

Various helpers to keep RetroPie easy to update.

## Needed:

- [Raspberry Pi 3](https://www.amazon.com/Rasberry-Pi-Model-Mother-board/dp/B01CD5VC92/?tag=cc0a0-20)
- [SD Card](https://www.amazon.com/SanDisk-microSDHC-Standard-Packaging-SDSQUNC-032G-GN6MA/dp/B010Q57T02/?tag=cc0a0-20)
- [8bitdo SFC30](https://www.amazon.com/SFC30-Wireless-Bluetooth-Controller-Joystick/dp/B00Y0LUQFE/?tag=cc0a0-20) (controller 1)
- [8bitdo SNES30](https://www.amazon.com/Wireless-Bluetooth-Controller-Classic-Joystick/dp/B00X3F0DW4/?tag=cc0a0-20) (controller 2)
- [8bitdo NES30 Pro](https://www.amazon.com/gp/product/B018K3Q4KS/?tag=cc0a0-20) (controller 3)

## Preparation

- 1. Flash the SD card w/ [RetroPie](http://blog.petrockblock.com/retropie/retropie-downloads/retropie-sd-card-image-for-raspberry-pi-2-2/)
- 2. Plug it in and boot it up!
- 3. In RetroPie GUI, configure WIFI
- 4. Find the ip
- 5. `ssh-copy-id pi@xxx.xxx.xxx.xxx` (Default pass is `raspberry`)
- 6. Add the IP to your ssh config and hosts file as `retropie`

### Install Ansible

- 1. Install Ansible 2.0+

### Setup Config Files

- 1. `cp systems.sample.json systems.json`
- 2. `cp roms.sample.json roms.json`
- 3. `cp secrets.sample.json secrets.json`
- 4. Edit to taste

## Available Tasks

#### Config

- `rake pi:config` - updates `/boot/config.txt`
- `rake pi:config:update` - updates RetroPie-Setup script
- `rake pi:config:retroarch` - updates/installs retroarch config
- `rake pi:config:controller` - installs controller stuff

#### Install files

- `rake pi:bios:install` - installs any bioses found in files/bios
- `rake pi:roms:all` - installs any roms setup in the `roms.json` file
- `rake pi:roms:snes` - installs any SNES roms setup in the `roms.json` file
  - Or replace snes with your choice of system

#### Sync data

- `rake pi:scraped:pull:snes` - Pulls gamelist/images for snes games FROM the pi TO local
  - Or replace snes with your choice of system
  - Or use `all` to do all at once
- `rake pi:scraped:push:snes` - Pushes gamelist/images for snes games TO the pi FROM local
  - Or replace snes with your choice of system
  - Or use `all` to do all at once

#### Enable/disable systems in ES

- `rake pi:disable snes` would hide the SNES menu item
  - Or use `rake pi:disable_all` to disable all systems marked disabled in your systems.json
- `rake pi:enable snes` would unhide the SNES menu item

#### Themes

- `rake pi:themes:install RetroPie/carbon` - Install a specific theme
- `rake pi:themes:all` - Install ALL themes!
- `rake pi:themes:recommended` - Install all recommended themes

#### Reboot the pi

- `rake pi:restart`

#### Quit current emulator

..useful if it's frozen/etc

- `rake pi:quit`

#### Full restore/backup

- `rake pi:backup`
- `rake pi:restore`
