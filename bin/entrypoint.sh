#!/bin/sh

# DEBUG Info for pipeline run
if [[ "$CI_DEBUG" == "true" ]]; then
  # print env info
  env
  # expands variables and prints a little + sign before the li
  set -o xtrace
fi

#
if [ ! -f /kaniko/executor ]; then
    if [[ "$CI_DEBUG" == "true" ]]; then
      echo "Preparing kaniko env"
    fi
    cp -pr /opt/kaniko/* /kaniko
fi

if [[ -n "$CI" ]]; then
    echo "this block will only execute in a CI environment"

    echo "now running script commands"
    # this is how GitLab expects your entrypoint to end, if provided
    # will execute scripts from stdin
    exec /bin/sh
else
    echo "Not in CI. Running the image normally"
    exec "$@"
fi
