# pip install jsonnet_binary
import _jsonnet

# jsonnet_file = "test.jsonnet"
# jsonnet_file = "my-yaml.jsonnet"
jsonnet_file = "my-json.jsonnet"
res = _jsonnet.evaluate_file(jsonnet_file)
print(res)
