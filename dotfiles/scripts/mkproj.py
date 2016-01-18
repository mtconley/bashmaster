# -*- coding: utf-8 -*-

import sys, os, re, getpass
from datetime import datetime
from clients import make_ipython_notebook
from clients.writers import HTMLWriter_01
from clients.apiclients import JiraHTMLMediator
from systools.utils import Directory
from systools.prompt import prompt_options

def parse_input(args):
    """Manage input arguments if from command line or prompt_options

    Parameters
    ----------
        :args: list
            command line arguments to parse

    """
    narg = len(args)
    if narg == 1:
        name = prompt_options('REL\d{1,6}$', 'Project Name: ')
        date = prompt_options([True, False], 'Add timestamp?')
    elif narg == 2:
        name = args[1]
        date = False
    elif narg > 2:
        name = args[1]
        date = bool(args[2])
    return name, date

def readme(issue):
    user = getpass.getuser()
    datestr = str(datetime.now())
    try:
        creation = JiraHTMLMediator(issue, HTMLWriter_01).build_html()
    except:
        creation = "Created by: {0}<br>\nCreated at: {1}".format(user, datestr)
    return creation

def requirements():
    text = """
    #Develop
    -e git+http://stash.teslamotors.com:7990/scm/rel/relpy.git@develop#egg=relpy
    http://static.dominoup.com/python-domino.tar.gz
    mysql-python
    xlrd
    turntable

    seaborn

    """
    return text

def make_project(name, date=False, template_dir=None,
                 root=None, dir_dict=None):
    match = re.findall('([a-zA-Z]{3})(\d{1,6})', name)
    if len(match):
        jira_issue = '-'.join(match[0])
    else:
        jira_issue = None

    new_dir = Directory(name, date, root)
    new_dir.make_tree(template_dir, dir_dict)
    new_dir.write(readme(jira_issue), 'README.md')
    path = os.path.join(new_dir.fullpath, 'ipynbs', new_dir.name)
    make_ipython_notebook(jira_issue, path)
    new_dir.write(requirements(), 'requirements.txt')

if __name__=='__main__':
    """Create directory structure for project
        Project_Name
        ├── ipynbs
        │   └──Project_Name.ipynb
        ├── results
        │   ├── data
        │   ├── figures
        │   ├── html
        │   └── model
        ├── scripts
        ├── README.md
        └── requirements.txt

    """
    #ask for user input on project details
    name, date = parse_input(sys.argv)

    dir_dict = {'ipynbs': None, 
                 'scripts': None, 
                 'results': {'data': None, 
                             'figures': None, 
                             'model': None,
                             'html': None}}
    make_project(name, date, dir_dict=dir_dict)
