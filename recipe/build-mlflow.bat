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

  @rem The lockfile is not installable in an immutable fashion on Windows
  set YARN_ENABLE_IMMUTABLE_INSTALLS=false
  cmd /c yarn install
  if %ERRORLEVEL% neq 0 exit 1
  cmd /c yarn build
  if %ERRORLEVEL% neq 0 exit 1

  popd
)

%PREFIX%/python.exe -m pip install . --no-deps --ignore-installed -vv
if %ERRORLEVEL% neq 0 exit 1

xcopy mlflow\server\js\build %SP_DIR%\mlflow\server\js\build /s /e /h /i

if [%PKG_NAME%] NEQ [mlflow-ui-dbg] (
  rmdir /s /q %SP_DIR%\mlflow\server\js\node_modules
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/css/*.css.map'
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/js/*.js.map'
)
