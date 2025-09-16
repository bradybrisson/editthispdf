#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image:tag>" >&2
    exit 1
fi

IMAGE="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="${SCRIPT_DIR}/deployment.yaml.tmpl"
OUTPUT_FILE="${SCRIPT_DIR}/deployment.yaml"

if [ ! -f "${TEMPLATE_FILE}" ]; then
    echo "Template not found: ${TEMPLATE_FILE}" >&2
    exit 1
fi

sed "s|{{IMAGE}}|${IMAGE}|g" "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

echo "Generated ${OUTPUT_FILE} with image ${IMAGE}"


