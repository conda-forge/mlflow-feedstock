#!/bin/bash

set -euxo pipefail

if [ ! -f pyproject.full.toml ]; then
  cp pyproject.toml pyproject.full.toml
fi

if [[ "${PKG_NAME}" == "mlflow-skinny" ]]; then
  export MLFLOW_SKINNY=1
  # https://github.com/mlflow/mlflow/pull/4134
  cp ${RECIPE_DIR}/README_SKINNY.rst ${SRC_DIR}
  cp pyproject.skinny.toml pyproject.toml
else
  cp pyproject.full.toml pyproject.toml
fi

$PREFIX/bin/python -m pip install . --no-deps --ignore-installed --no-build-isolation -vv
if [[ "$PKG_NAME" != "mlflow-ui-dbg" ]]; then
  rm -f $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/css/*.css.map
  rm -f $PREFIX/lib/python${PY_VER}/site-packages/mlflow/server/js/build/static/js/*.js.map
fi
