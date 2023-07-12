# Post-installation files
Before doing anything else, update current software using ```sudo apt update && sudo apt upgrade```

### Configure Grub
```sudo update-grub```

### Get audio/video codecs
```sudo apt install ubuntu-restricted-extras```

### Fix time when dual booting Windows
```timedatectl set-local-rtc 1```

### Python
Install Anaconda to separate system version from user version.
