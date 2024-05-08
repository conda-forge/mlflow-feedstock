@echo on

if not exist pyproject-full.toml (
    copy pyproject.toml pyproject.full.toml
)

if [%PKG_NAME%] == [mlflow-skinny] (
  set MLFLOW_SKINNY=1
  # https://github.com/mlflow/mlflow/pull/4134
  copy %RECIPE_DIR%/README_SKINNY.rst %SRC_DIR%
  copy pyproject.skinny.toml pyproject.toml
) else (
  copy pyproject.full.toml pyproject.toml
)

if [%PKG_NAME%] == [mlflow-ui] (
  pushd mlflow\server\js
  yarn install --frozen-lockfile
  if %ERRORLEVEL% neq 0 exit 1
  yarn build
  if %ERRORLEVEL% neq 0 exit 1
  popd
)

%PREFIX%/python.exe -m pip install . --no-deps --ignore-installed -vv

if [%PKG_NAME%] NEQ [mlflow-ui-dbg] (
  rmdir /s /q $SP_DIR\mlflow\server\js\node_modules
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/css/*.css.map'
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/js/*.js.map'
)
