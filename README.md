This is a simple script to start Pico-8 Splore before emulationstation in JELOS.

# Installing

SSH into your device and run the following commands:

```sh
cd ~
git clone https://github.com/AnthonyDiGirolamo/jelos-splore-autostart
cd ~/jelos-splore-autostart
./install.sh
```

# Uninstalling

```sh
cd ~
cd ~/jelos-splore-autostart
./uninstall.sh
```

# Manual install

The `start_splore.sh` script needs to be copied into
`/storage/.config/autostart/`. All scripts in that directory are run before
emulationstation starts on JELOS.
