NAMESPACE?=zipkin-example
CHART_NAME=zipkin-k8-example

deps:
	helm dependency update

install:
	helm install -f values.yaml -n $(NAMESPACE) --create-namespace $(CHART_NAME) ./

install-dry:
	helm install -f values.yaml -n $(NAMESPACE) $(CHART_NAME) --dry-run --debug ./

upgrade:
	helm upgrade -f values.yaml -n $(NAMESPACE) $(CHART_NAME) ./

uninstall:
	helm uninstall $(CHART_NAME)

expose-frontend:
	kubectl -n $(NAMESPACE) port-forward `kubectl get pods --template '{{range .items}}{{.metadata.name}}{{end}}' -n "$(NAMESPACE)" -l app=frontend` 8081:8081

expose-zipkin:
	kubectl -n $(NAMESPACE) port-forward `kubectl get pods --template '{{range .items}}{{.metadata.name}}{{end}}' -n "$(NAMESPACE)" -l app.kubernetes.io/name=zipkin` 9411:9411