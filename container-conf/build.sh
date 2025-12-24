#!/bin/bash

build_as_run_user() {
    # Reistall, because beamsim-jupyter-base is slow to build so
    # that doesn't get built every release.
    install_git_clone pykern "$PYKERN_BRANCH"
    cd pykern
    install_pip_install .
    cd ..
    install_git_clone sirepo "$SIREPO_BRANCH"
    cd sirepo
    install_pip_install .
    cd ..
}


_beamsim_jupyter_build_vars() {
    : ${build_image_base:=radiasoft/beamsim-jupyter-base}
    build_is_public=1
    build_passenv='PYKERN_BRANCH SIREPO_BRANCH'
    : ${PYKERN_BRANCH:=} ${SIREPO_BRANCH:=}
    # POSIT: comes from beamsim-jupyter-base
    beamsim_jupyter_boot_dir=$build_run_user_home/.radia-run
    beamsim_jupyter_radia_run_boot=$beamsim_jupyter_boot_dir/start
    build_docker_cmd=$beamsim_jupyter_radia_run_boot
}

_beamsim_jupyter_build_vars
