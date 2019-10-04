# GKE Build Deploy Action
Build a container image from a Dockerfile, push to GDR, and deploy to GKE.

## Inputs

### `gcrHostname`

**Required** The Google Docker Registry hostname.

### `gkeApplicationCredentials`

**Required** The service account credentials JSON file encoded as a base64 string to access the GKE API.

### `gkeProjectID`

**Required** The GKE project identifier (kube-cluster-12345).

### `gkeClusterName`

**Required** The name of the Kubernetes cluster.

### `gkeLocationZone`

**Required** The cluster's location zone.

### `gitUsername`

**Required** The git username to use when cloning dependencies.

### `gitAccessToken`

**Required** The access token associated with the user passed to gitUsername.

### `requiresTALib`

**Optional** (Defaults to false) Whether or not the image requires the use of TA-Lib.

## Example usage

```yaml
uses: cryptopirates/gke-build-deploy-action
with:
    gcrHostname: ${{ secrets.GCR_HOSTNAME }}
    gkeApplicationCredentials: ${{ secrets.GKE_APPLICATION_CREDENTIALS }}
    gkeNamespace: ${{ secrets.GKE_NAMESPACE }}
    gkeProjectID: ${{ secrets.GKE_PROJECT_ID }}
    gkeClusterName: ${{ secrets.GKE_CLUSTER_NAME }}
    gkeLocationZone: ${{ secrets.GKE_LOCATION_ZONE }}
    gitUsername: ${{ secrets.GIT_USERNAME }}
    gitAccessToken: ${{ secrets.GIT_ACCESS_TOKEN }}
    requiresTALib: true
```