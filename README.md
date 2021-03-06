# GKE Build Deploy Action
Build a container image from a Dockerfile, push to GCR, and deploy to GKE. Some things to note:

- The image is tagged with the current branch and first seven characters of the commit's hash (master-a1b2c3d)
- The action will attempt to update the deployment's config map by looking for the file `/.gke/values.env`.

In general your project directory should look like:

```
/.gke/values.env
/Dockerfile
```

## Inputs

### `gcrHostname`

**Required** The Google Docker Registry hostname.

### `gkeApplicationCredentials`

**Required** The service account credentials JSON file encoded as a base64 string to access the GKE API.

### `gkeProjectID`

**Required** The GKE project identifier (kube-cluster-12345).

### `gkeClusterName`

**Required** The name of the Kubernetes cluster.

### `dkeDeploymentName`

**Required** The name of the container's deployment.

### `gkeLocationZone`

**Required** The cluster's location zone.

### `gitUsername`

**Required** The git username to use when cloning dependencies.

### `gitAccessToken`

**Required** The access token associated with the user passed to gitUsername.

## Example usage

```yaml
uses: cryptopirates/gke-build-deploy-action@master
with:
    gcrHostname: ${{ secrets.GCR_HOSTNAME }}
    gkeApplicationCredentials: ${{ secrets.GKE_APPLICATION_CREDENTIALS }}
    gkeNamespace: ${{ secrets.GKE_NAMESPACE }}
    gkeProjectID: ${{ secrets.GKE_PROJECT_ID }}
    gkeClusterName: ${{ secrets.GKE_CLUSTER_NAME }}
    gkeDeploymentName: ${{ secrets.GKE_DEPLOYMENT_NAME }}
    gkeLocationZone: ${{ secrets.GKE_LOCATION_ZONE }}
    gitUsername: ${{ secrets.GIT_USERNAME }}
    gitAccessToken: ${{ secrets.GIT_ACCESS_TOKEN }}
```