typeset -U fpath
fpath=(${ZDOTDIR}/functions $fpath)
autoload source-dir
source-dir ${ZDOTDIR}/env
