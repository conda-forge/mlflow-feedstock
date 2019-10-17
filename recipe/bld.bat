%PREFIX%/python.exe -m pip install . --no-deps --ignore-installed -vv
bash -c 'rm ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/css/*.css.map'
bash -c 'rm ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/js/*.js.map'