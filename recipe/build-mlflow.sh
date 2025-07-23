#!/bin/bash

set -euxo pipefail

if [[ "${PKG_NAME}" == "mlflow-ui" ]]; then
  pushd mlflow/server/js
  yarn install
  yarn build
  popd
fi

if [[ "${PKG_NAME}" == "mlflow-skinny" ]]; then
  export MLFLOW_SKINNY=1
  $PREFIX/bin/python -m pip install ../libs/skinny --no-deps --ignore-installed --no-build-isolation -vv
else
  $PREFIX/bin/python -m pip install . --no-deps --ignore-installed --no-build-isolation -vv
fi

if [[ "$PKG_NAME" != "mlflow-ui-dbg" ]]; then
  rm -rf $SP_DIR/mlflow/server/js/node_modules
  rm -f $SP_DIR/mlflow/server/js/build/static/css/*.css.map
  rm -f $SP_DIR/mlflow/server/js/build/static/js/*.js.map
fi
