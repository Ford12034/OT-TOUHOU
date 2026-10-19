# OT-TOUHOU

An OT/ICS cybersecurity CTF project.

## Components

- OpenPLC source files and Docker build files.
- Decoy services for cybersecurity lab exercises.
Modbus running on port 1502, decoys on 8080, and 502
## Container Images

- OpenPLC: ghcr.io/ford12034/ot-touhou-openplc:latest
- Decoys: ghcr.io/ford12034/ot-touhou-decoys:latest

## Pull Images

```powershell
docker pull ghcr.io/ford12034/ot-touhou-openplc:latest
docker pull ghcr.io/ford12034/ot-touhou-decoys:latest
```

Use only in authorized cybersecurity labs. Keep credentials and backups out of source control.
