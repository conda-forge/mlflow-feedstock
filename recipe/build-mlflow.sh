#!/bin/bash

set -euxo pipefail

if [[ "${PKG_NAME}" == "mlflow-ui" ]]; then

  FILENAME="mlflow-${PKG_VERSION}.tar.gz"
  DOWNLOAD_URL="https://files.pythonhosted.org/packages/source/m/mlflow/${FILENAME}"
  TMP_DIR="$(mktemp -d)"
  TAR_PATH="${TMP_DIR}/${FILENAME}"
  EXTRACT_DIR="${TMP_DIR}/mlflow-${PKG_VERSION}"

  echo "Downloading ${FILENAME}..."
  curl -fL -o "${TAR_PATH}" "${DOWNLOAD_URL}"

  echo "Extracting to ${EXTRACT_DIR}..."
  mkdir -p "${EXTRACT_DIR}"
  tar -xzf "${TAR_PATH}" -C "${EXTRACT_DIR}" --strip-components=1

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
