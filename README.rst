Auto-documentation of the turkpow model
=======================================

The documentation of the turkpow model is generated from rst files included in ``doc``
and from mark-up comments in the GAMS code written in restructured text by Sphinx_.


Dependencies
------------

Install all the sphinx dependencies with Anaconda or Mamba::

    $ mamba env create -f environment.yml
    $ conda activate sphinx-gams


Writing in Restructured Text
----------------------------

There are a number of guides out there, e.g. on docutils_.


Building the docs on your local machine
---------------------------------------

From the command line, run::

    make html

You can then view the site by::

    cd _build/html
    python -m SimpleHTTPServer

and pointing your browser at http://localhost:8000/


Live updates
------------

Alternatively, you can use ``sphinx-autobuild`` to see the impact of your
changes whenever you save a file.

From the command line, run::

    cd docs
    sphinx-autobuild --ignore="*/docs/model/*" --watch=../model . _build/html

The extra ignore and watch statements make sure that the automatically extracted
ReST files in ``docs/model`` do not trigger a re-run while updates in the model
folder are also picked up.
    

Github Pages
-------------

On Github pages, the documentation is built using a command similar to::

    sphinx-build -b html . _build/html

This command is executed in the directory containing `conf.py`, i.e.
`docs/`. Use this to test whether the documentation build works on
GH Pages.

.. _Sphinx: http://sphinx-doc.org/
.. _docutils: http://docutils.sourceforge.net/docs/user/rst/quickref.html
