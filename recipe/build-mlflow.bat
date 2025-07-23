@echo on

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

if [%PKG_NAME%] == [mlflow-skinny] (
  set MLFLOW_SKINNY=1
  %PREFIX%/python.exe -m pip install ../libs/skinny --no-deps --ignore-installed -vv
) else (
  %PREFIX%/python.exe -m pip install . --no-deps --ignore-installed -vv
)

if %ERRORLEVEL% neq 0 exit 1

xcopy /i /s /y mlflow\server\js\build %SP_DIR%\mlflow\server\js\build

if [%PKG_NAME%] NEQ [mlflow-ui-dbg] (
  rmdir /s /q %SP_DIR%\mlflow\server\js\node_modules
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/css/*.css.map'
  bash -c 'rm -f ${SP_DIR//\\\\//}/mlflow/server/js/build/static/js/*.js.map'
)
