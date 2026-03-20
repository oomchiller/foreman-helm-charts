HELM ?= helm

.PHONY: lint template validate

lint:
	$(HELM) lint ./charts/foreman
	$(HELM) lint ./charts/foreman --set apache.enabled=true
	$(HELM) lint ./charts/foreman --set apache.enabled=false
	$(HELM) lint ./charts/foreman-proxy
	$(HELM) lint ./charts/foreman --set 'ingress.enabled=true' --set 'foreman.fqdn[0]=foreman.example.com' --set 'ingress.tls[0].hosts[0]=foreman.example.com' --set 'ingress.tls[0].secretName=foreman-tls'
	$(HELM) lint ./charts/foreman-proxy --set 'ingress.enabled=true' --set 'ingress.fqdn=proxy.example.com' --set 'ingress.tls[0].hosts[0]=proxy.example.com' --set 'ingress.tls[0].secretName=proxy-tls'

template:
	$(HELM) template demo ./charts/foreman >/dev/null
	$(HELM) template demo ./charts/foreman --set apache.enabled=true >/dev/null
	$(HELM) template demo ./charts/foreman-proxy >/dev/null

validate: lint template
