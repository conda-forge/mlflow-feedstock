#!/bin/bash

set -euo pipefail

ls -l
mkdir -p $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/css/
cp $SRC_DIR/mlflow/server/js/build/static/css/*.css.map $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/css/
mkdir -p $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/js/
cp $SRC_DIR/mlflow/server/js/build/static/js/*.js.map $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/js/
