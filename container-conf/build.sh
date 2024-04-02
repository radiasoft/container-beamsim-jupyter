#!/bin/bash

_beamsim_jupyter_build_vars() {
    : ${build_image_base:=radiasoft/beamsim-jupyter-base}
    build_is_public=1
    build_passenv='PYKERN_COMMIT SIREPO_COMMIT'
    : ${PYKERN_COMMIT:=} ${SIREPO_COMMIT:=}
}

build_as_run_user() {
    cd "$build_guest_conf"
    _beamsim_jupyter_clone pykern "$PYKERN_COMMIT"
    pip install .
    cd ..
    _beamsim_jupyter_clone sirepo "$SIREPO_COMMIT"
    pip install -e .
    sirepo srw create_predefined
    pip install .
    cd ..
}

_beamsim_jupyter_clone() {
    declare repo=$1
    declare commit=$2
    git clone -q -c advice.detachedHead=false ${commit:+--branch "$commit"} --depth=1 https://github.com/radiasoft/"$repo"
    cd $repo
}

_beamsim_jupyter_build_vars
