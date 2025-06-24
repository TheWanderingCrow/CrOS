default:
  just -l

# Update secrets input
update-secret:
  nix flake update nix-secrets && \
  git add -u && (git commit -am 'chore: update secrets input' || true) && \
  git push
