# Dockerfile Creator Action

This GitHub Action automatically creates a Dockerfile, builds the image, and runs it using Nginx. It also verifies the container status.

## Inputs
| Input | Description | Default |
|-------|-------------|----------|
| `port` | Port for the container to run on | `4587` |

## Example Usage
```yaml
jobs:
  build-and-run:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run Dockerfile Creator
        uses: ./
        # uses: melvinsamuel070/dockerfile-creator@v1
        with:
          port: 4587
