bash -c 'rm ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/css/*.css.map'
bash -c 'mkdir -p ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/css/'
bash -c 'cp ${SRC_DIR//\\\\//}/mlflow/server/js/build/static/css/*.css.map ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/css/
bash -c 'mkdir -p ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/js/
bash -c 'cp ${SRC_DIR//\\\\//}/mlflow/server/js/build/static/js/*.js.map ${PREFIX//\\\\//}/Lib/site-packages/mlflow/server/js/build/static/js/
