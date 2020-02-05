typeset -U fpath
fpath=(${ZDOTDIR}/functions $fpath)
autoload -Uz ${ZDOTDIR}/functions/*(.)
source-dir ${ZDOTDIR}/env
