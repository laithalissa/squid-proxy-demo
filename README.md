# Demo on configuring forward proxy ACLs

- See [etc/squid.conf](etc/squid.conf) for config
- See [results.md](results.md) for connection matrix

This demos intentionally conflates response codes becuase when the
proxy blocks us, we're interested in the http_connect response
code rather than the http_code.

# Usage:
```bash
docker-compose up -d
./test-clients.sh
```
