resource "kubernetes_manifest" "example-app-deployment" {
  manifest = yamldecode(<<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-app
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: example-app
  template:
    metadata:
      labels:
        app: example-app
    spec:
      containers:
      - name: example-app
        image: fabxc/instrumented_app
        ports:
        - name: web
          containerPort: 8080
  EOF
  )
}

resource "kubernetes_manifest" "example-app-service" {
  manifest = yamldecode(<<EOF
kind: Service
apiVersion: v1
metadata:
  name: example-app
  namespace: default
  labels:
    app: example-app
spec:
  selector:
    app: example-app
  ports:
  - name: web
    port: 8080
  EOF
  )
}

resource "kubernetes_manifest" "example-app-svcmonitor" {
  manifest = yamldecode(<<EOF
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: example-app
  namespace: default
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      app: example-app
  endpoints:
  - port: web
  EOF
  )
}
