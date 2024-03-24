// ... (same as above until the last part)
local deployment = {
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: 'my-app-deployment',
    labels: {
      app: 'my-app',
    },
  },
  spec: {
    replicas: 3,
    selector: {
      matchLabels: {
        app: 'my-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'my-app',
        },
      },
      spec: {
        containers: [
          {
            name: 'my-app-container',
            image: 'myregistry/myapp:1.0',
            ports: [
              {
                containerPort: 8080,
              },
            ],
            env: [
              {
                name: 'SECRET_USERNAME',
                valueFrom: {
                  secretKeyRef: {
                    name: 'my-app-secret',
                    key: 'username',
                  },
                },
              },
              {
                name: 'SECRET_PASSWORD',
                valueFrom: {
                  secretKeyRef: {
                    name: 'my-app-secret',
                    key: 'password',
                  },
                },
              },
            ],
            // Note: Volume mounts would go here if needed for the ConfigMap.
            // volumeMounts: [...],
          },
        ],
        // Note: Volumes would go here if needed for the ConfigMap.
        // volumes: [...],
      },
    },
  },
};

local secret = {
  apiVersion: 'v1',
  kind: 'Secret',
  metadata: {
    name: 'my-app-secret',
  },
  type: 'Opaque',
  data: {
    username: std.base64('admin'), // Replace 'admin' with your actual username
    password: std.base64('password'), // Replace 'password' with your actual password
  },
};

local configMap = {
  apiVersion: 'v1',
  kind: 'ConfigMap',
  metadata: {
    name: 'my-app-configmap',
  },
  data: {
    'app.properties': 'app.name=MyApp\napp.version=1.0\napp.environment=production',
    'logging.properties': 'log.level=INFO\nlog.file=/var/log/myapp.log',
  },
};

{
  'deployment': std.manifestYamlDoc(deployment),
  'secret': std.manifestYamlDoc(secret),
  'configmap': std.manifestYamlDoc(configMap),
}