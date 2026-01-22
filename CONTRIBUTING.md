# Introduction

This document contains instructions on how to contribute to this repo.

## Adding new code list data set

To add the a new code list data set follow the structure descrebed below:

The data is grouped together in categories such as conditions, sociodemographics/lifestyle, medications/devices, etc., and specific datasets are defined by:

* A set of code lists in CSV format.
* A markdown document called `info.md` which contains a brief description of the condition, the rules used to generate the codelist datasets, and the original data sources used.

## To build the documentation locally

First make sure you have the right environment to run mkdocs. To do this create a python virtual environment:

`python -m venv venv`

Then activate the environment:

`source venv/bin/activate`

Finally install the necessary requirements:

`pip install -r docs/requirements.txt`

Now to build the documetation from scratch issue the following command in a bash terminal, for the root directory of your local working copy of the repository:

`./docs/scripts/build_docs.sh`

This will copy the code_lists and projects directories into the docs directory, and run the `mkdocs build command`. The latter will generate a `site` folder in the root directory of your local working copy. 

To view the documentation just point your web browser to open the file `index.html` in the `site` directory.

If you want to clear the generated documentation and start from afresh issue the following command:

`./docs/scripts/clean_docs.sh`