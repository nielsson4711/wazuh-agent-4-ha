#!/bin/sh
# shellcheck disable=SC2015
set -e

GIT_USER="${GIT_USER:-nielsson4711}"
GIT_REPO="${GIT_REPO:-wazuh-agent-4-ha"}
GIT_BRANCH="${GIT_BRANCH:-adopt}"

# Install packages

PACKAGES="$1"
echo "Packages to install : $PACKAGES"

# Install bash if needed
if ! command -v bash >/dev/null 2>/dev/null; then
    (apt-get update && apt-get install -yqq --no-install-recommends bash || apk add --no-cache bash) >/dev/null
fi

# Install curl if needed
if ! command -v curl >/dev/null 2>/dev/null; then
    (apt-get update && apt-get install -yqq --no-install-recommends curl || apk add --no-cache curl) >/dev/null
fi

# Call apps installer script if needed
curl -f -L -s -S "https://raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${GIT_BRANCH}/.scripts/ha_install_packages.sh" --output /ha_install_packages.sh
chmod 777 /ha_install_packages.sh
eval /./ha_install_packages.sh "${PACKAGES:-}"

# Clean
rm /ha_install_packages.sh
