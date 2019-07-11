#!/bin/bash

set -euo pipefail

$PREFIX/bin/python -m pip install . --no-deps --ignore-installed -vv
rm $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/css/*.css.map
rm $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/js/*.js.map
