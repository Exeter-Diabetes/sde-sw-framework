# Introduction

This document contains instructions on how to contribute to this repo.

## Adding new code list data set

To add the a new code list data set follow the structure described below:

The data is grouped together in categories such as conditions, sociodemographics, medications, etc., and specific datasets are defined by:

* A set of code lists in CSV format.
* A markdown document called `info.md` which contains a brief description of the condition, the rules used to generate the codelist datasets, the original data sources used and links to data sets.

## To build the documentation locally

First make sure you have the right environment to run mkdocs. To do this create a python virtual environment:

```bash
python -m venv venv
```

Then activate the environment:

```bash
source venv/bin/activate
```

Finally install the necessary requirements:

```bash
pip install -r docs/requirements.txt
```

Now to build the documetation from scratch issue the following command in a bash terminal, from the root directory of your local working copy of the repository:

```bash
./docs/scripts/build_docs.sh
```

This script will:

* copy the code_lists and projects directories into the docs directory, and 

* run the `mkdocs build` command. The latter will generate a `site` folder in the root directory of your local working copy. 

To view the generated site run the following command, from the root directory of your local working copy of the repository:

```bash
mkdocs serve
```

and then point your browser to the url `http://127.0.0.1:8000/`. To stop the serving of the website locally just do `Ctrl + C` in the terminal.

Note any changes you make in the `code_lists` or `projects` directories will automatically be picked when doing a new build. If you want to clear the copied/generated documentation from your local working copy, issue the following command:

```bash
./docs/scripts/clean_docs.sh
```