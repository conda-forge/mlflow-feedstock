@echo on

if not exist pyproject-full.toml (
    copy pyproject.toml pyproject.full.toml
)

if [%PKG_NAME%] == [mlflow-skinny] (
  set MLFLOW_SKINNY=1
  # https://github.com/mlflow/mlflow/pull/4134
  copy %RECIPE_DIR%/README_SKINNY.rst %SRC_DIR%
  copy pyproject.skinny.toml pyproject.toml

  pushd mlflow/server/js
  yarn install
  yarn build
  popd
) else (
  copy pyproject.full.toml pyproject.toml
)

%PREFIX%/python.exe -m pip install . --no-deps --ignore-installed -vv

if [%PKG_NAME%] NEQ [mlflow-ui-dbg] (
  bash -c 'rm -f ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/css/*.css.map'
  bash -c 'rm -f ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/js/*.js.map'
)
