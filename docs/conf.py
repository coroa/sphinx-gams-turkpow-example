# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.

import sys
from pathlib import Path
root_path = Path(__file__).parent
sys.path.insert(0, str(root_path.absolute() / "exts"))

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'turkpow example'
copyright = '2022, Some institute'
author = 'turkpow developers'


# The major project version, used as the replacement for |version|.
version = "0.1"
# The full project version, used as the replacement for |release| and e.g. in
# the HTML templates.
release = version

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.doctest",
    "sphinx.ext.todo",
    "sphinx.ext.coverage",
    "sphinx.ext.mathjax",
    "sphinxcontrib.bibtex",
    "sphinx.ext.autosummary",
    "sphinx.ext.napoleon",
    "sphinx_gams",
]

templates_path = ['_templates']
exclude_patterns = ['README.rst', '_build', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']


# -- Options for LaTeX output -------------------------------------------------

# The LaTeX engine to build the docs.
latex_engine = "lualatex"


# -- Options for sphinx.ext.todo ----------------------------------------------

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = True


# -- Options for sphinxcontrib.bibtex -----------------------------------------

bibtex_bibfiles = ["references.bib"]


# -- Options for message_ix.util.sphinx_gams -------------------------------------------

gams_source_dir = root_path.parent / "model"
gams_target_dir = "model"
