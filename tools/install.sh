#!/usr/bin/env bash
# Installs istioctl, which the Istio Service Mesh Workshop uses, into the tools image, on top
# of the shared tools (oc, kubectl, helm, jq, yq, git, curl, wget, skopeo, docker shim).
# The image build runs it as root, with TARGETARCH set to amd64 or arm64.
set -euo pipefail

# The latest patch of the Istio release the pages target (istio_version in
# content/antora.yml); keep the two in step.
ISTIO_VERSION=1.30.6

case "$TARGETARCH" in
  amd64|arm64) ;;
  *) echo "unsupported TARGETARCH=$TARGETARCH" >&2; exit 1 ;;
esac

curl -sSL "https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istioctl-${ISTIO_VERSION}-linux-${TARGETARCH}.tar.gz" \
  | tar -xz -C /usr/local/bin istioctl
chmod 0755 /usr/local/bin/istioctl
