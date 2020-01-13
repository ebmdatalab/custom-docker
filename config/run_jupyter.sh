#!/bin/bash

cd ~
mkdir .jupyter
mkdir -p .local/share/jupyter/kernels/python3/

# copy the jupyter configuration into home-directory
cp -r ${CONFIG_PATH}/jupyter_notebook_config.py ~/.jupyter/

cd ${MAIN_PATH}


# edit the python3 kernel, to make it possible to import from libs/ from anywhere


cat > ~/.local/share/jupyter/kernels/python3/kernel.json <<EOKERN
{
    "display_name": "Python 3",
    "language": "python",
    "argv": [
        "python3",
        "-c", "import sys, os; sys.path.insert(0, os.path.dirname(os.environ['LIBS_PATH'])); from IPython.kernel.zmq.kernelapp import main; main()",
        "-f", "{connection_file}"
    ],
    "codemirror_mode": {
        "version": 2,
        "name": "ipython"
    }
}
EOKERN

mkdir -p notebooks

jupyter lab
