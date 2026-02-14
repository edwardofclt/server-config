#!/bin/bash
set -exuo pipefail

DOMAIN=edwardofclt.com
export DOMAIN

base="/plex"
base_compose="$base/docker-compose.yml"

args=(-f "$base_compose")

while IFS= read -r compose_file; do
  args+=(-f "$compose_file")
done < <(find "$base" -mindepth 2 -maxdepth 2 -type f \( -name "docker-compose.yml" -o -name "docker-compose.yaml" \) -print)

# Run from /plex so relative paths in compose files behave as expected
cd "$base"
docker compose "${args[@]}" up -d --pull always
