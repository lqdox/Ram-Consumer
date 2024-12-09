# Ram Consumer

## Overview



- Service Name: consume_ram

- Consume 0.2% of Hardware RAM every second

- If the remaining RAM < 10%, reset the process

## Build

### Build pkg

```bash
dpkg-deb --build ram_consumer_pkg
```

### Install

```bash
sudo dpkg -i ram_consumer_pkg.deb
```

### Uninstall

```bash
sudo apt remove ram-consumer
```

## Verify if service is running

```bash
systemctl status consume_ram.service
```
