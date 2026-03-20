# Foreman Helm Charts

This repo contains simple Helm charts for Foreman and Foreman Smart Proxy.

- `charts/foreman`
- `charts/foreman-proxy`

## Validate

```sh
make validate
```

Note: these charts depend on external Redis, PostgreSQL, Foreman images, and TLS certificates.
