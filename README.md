# qbittorrent-port-forward-gluetun-server

A shell script and Docker container for automatically setting qBittorrent's listening port from Gluetun's control server.

This version assumes qbittorrent has been configured to whitelist the Docker local network, and that qbittorrent is bound to gluetun.

## Config

### Environment Variables

| Variable  | Example    | Default    | Description                          |
|-----------|------------|------------|--------------------------------------|
| QBT_PORT  | `9090`     | `8080`     | Port for the qBittorrent web UI      |
| GTN_PORT  | `9000`     | `8000`     | Port for the gluetun control server  |
| GTN_HOST  | `vpnserv`  | `gluetun`  | Hostname for gluetun                 |

## Example

### Docker-Compose

The following is an example docker-compose:

```yaml
  qbittorrent-port-forward-gluetun-server:
    image: cezero/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      - QBT_PORT=9090
      - GTN_PORT=9000
      - GTN_HOST=vpnserv
```

## Development

### Build Image

`docker build . -t qbittorrent-port-forward-gluetun-server`

### Run Container

`docker run --rm -it -e QBT_PORT=9090 -e GTN_PORT=9000 -e GTN_HOST=vpnserv qbittorrent-port-forward-gluetun-server:latest`
