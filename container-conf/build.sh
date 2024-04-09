#!/bin/bash

_beamsim_jupyter_build_vars() {
    : ${build_image_base:=radiasoft/beamsim-jupyter-base}
    build_is_public=1
    build_passenv='PYKERN_BRANCH SIREPO_BRANCH'
    : ${PYKERN_BRANCH:=} ${SIREPO_BRANCH:=}
    # POSIT: comes from beamsim-jupyter-base
    beamsim_jupyter_boot_dir=$build_run_user_home/.radia-run
    beamsim_jupyter_radia_run_boot=$beamsim_jupyter_boot_dir/start
    build_docker_cmd='["'"$beamsim_jupyter_radia_run_boot"'"]'
}

build_as_run_user() {
    cd "$build_guest_conf"
    _beamsim_jupyter_clone pykern "$PYKERN_BRANCH"
    pip install .
    cd ..
    _beamsim_jupyter_clone sirepo "$SIREPO_BRANCH"
    pip install -e .
    sirepo srw create_predefined
    pip install .
    cd ..
}

_beamsim_jupyter_clone() {
    declare repo=$1
    declare branch=$2
    git clone -q -c advice.detachedHead=false ${branch:+--branch "$branch"} --depth=1 https://github.com/radiasoft/"$repo"
    cd $repo
}

_beamsim_jupyter_build_vars
