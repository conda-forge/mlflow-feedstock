#!/bin/bash

set -euxo pipefail

if [[ "${PKG_NAME}" == "mlflow-ui" ]]; then

  EXTRACT_DIR="${SRC_DIR}/mlflow-${PKG_VERSION}"

  SRC_JS_BUILD="${EXTRACT_DIR}/mlflow/server/js/build"
  DEST_DIR="mlflow/server/js/build"

  echo "Moving ${SRC_JS_BUILD} to ${DEST_DIR}..."
  rm -rf "${DEST_DIR}"
  mv "${SRC_JS_BUILD}" "${DEST_DIR}"

  echo "The files in $DEST_DIR are:"
  ls $DEST_DIR
fi

if [[ "${PKG_NAME}" == "mlflow-skinny" ]]; then
  export MLFLOW_SKINNY=1
  $PREFIX/bin/python -m pip install ./skinny --no-deps --ignore-installed --no-build-isolation -vv
else
  $PREFIX/bin/python -m pip install . --no-deps --ignore-installed --no-build-isolation -vv
fi

if [[ "$PKG_NAME" != "mlflow-ui-dbg" ]]; then
  rm -rf $SP_DIR/mlflow/server/js/node_modules
  rm -f $SP_DIR/mlflow/server/js/build/static/css/*.css.map
  rm -f $SP_DIR/mlflow/server/js/build/static/js/*.js.map
fi
