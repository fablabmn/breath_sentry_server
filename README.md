# Sentry IoT Stack

MQTT + Node-RED + InfluxDB + Grafana on Docker.

## Stack

| Service | Access |
|---|---|
| Node-RED | `https://localhost/` |
| Grafana | `https://localhost/grafana/` |
| MQTTS | `tls://localhost:8883` |
| InfluxDB | internal only |

## First run

```bash
git clone <repo>
cd <repo>
./generate-certs.sh
docker compose up -d
```

## API

```
GET /sentry/environment_data?board_id=BOARD_001
GET /sentry/lists
```

## Notes

- On a new machine, regenerate certs with `./generate-certs.sh`
- Restore `nodered/data/flows_cred.json` manually (not in repo)
- InfluxDB data is not in repo — starts fresh on new machine
