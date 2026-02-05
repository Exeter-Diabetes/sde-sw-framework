# Introduction

This document contains instructions on how to contribute to this repo.

## How to contribute to this repository

### Fork the repository

* Navigate to the original (upstream) repository on GitHub.

* Click the Fork button in the top-right corner to create a personal copy in your account.

* Clone your fork to your local machine using the GitHub CLI or standard Git commands:

    ```bash
    git clone https://github.com/Exeter-Diabetes/sde-sw-framework.git
    ```

* Configure Remotes to link your local project to the original repository so you can pull updates:

    ```bash
    git remote add upstream https://github.com/Exeter-Diabetes/sde-sw-framework.git
    ```

### Merging Across Forks (Feature to Dev)
To propose changes from your fork's feature branch to the parent's dev branch, follow these steps: 

* Create a feature branch locally for your changes:

    ```bash
    git checkout -b feature-branch-name
    ```

* Stage the files you changed/added/deleted using the `git add` command so they are ready to be committed. Then  commit and push your work to your fork:

    ```bash
    git commit -a "Short description of changes"
    git push -u origin feature-branch-name
    ```

* Open a Pull Request (PR) by going to your fork on GitHub and clicking Compare & pull request.

* Set Target Branches by clicking compare across forks on the PR page:
    * Base repository: Select the original parent repository.
    * Base branch: Change this from main to dev.
    * Head repository: Select your personal fork.
    * Compare branch: Select your feature-name branch.

* Submit the PR for the parent repo maintainers to review.

### Adding new code list data set

To add the a new code list data set follow the structure described below:

The data is grouped together in categories such as conditions, sociodemographics, medications, etc., and specific datasets are defined by:

* A set of code lists in CSV format.
* A markdown document called `info.md` which contains a brief description of the condition, the rules used to generate the codelist datasets, the original data sources used and links to data sets.

## How to build the documentation locally

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