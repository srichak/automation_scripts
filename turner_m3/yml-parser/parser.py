#!/usr/bin/python
import os
import sys
import re
import logging
import yaml
import types
import pprint

# Setting logging
logger = logging.getLogger('parser')
logger.setLevel(logging.INFO)
ch = logging.StreamHandler()
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)

# functions

def readFileYAML( infile ):
    "Converts to YAML formatted object"
    steps = []
    logger.info("Reading yaml instructionset")
    with open(infile, 'r') as stream:
        try:
            steps = yaml.load(stream)
	    if 'steps' in steps:
                return steps['steps']
	    else:
                logger.error("Input file does not contain any 'steps'!")
                sys.exit() 
        except yaml.YAMLError as exc:
            logger.warn(exc)

def yamlNestToBash( outfile, varname, nest, sub=None ):
    text = ''
    for item in nest:
        if sub is None:
            text += item
        else:
            text += item[sub]
        if item is not nest[-1]:
            text += ','
    text = '{}="{}"\n'.format(varname,text)
    outfile.write(text)

def yamlNestToAnsible( outfile, varname, nest ):
    text = '{}:\n'.format(varname)
    for item in nest:
        if not isinstance(item,types.StringTypes):
            text += '  - '
        else:
            text += '  '
        text += '{}\n'.format(item)
    outfile.write(text)

def writeModuleSQL( step, path ):
    ansible = open(path+'/vars.yml','w')
    bash = open(path+'/vars.sh','w')

    bash.write('mdoule={}\n'.format(step['module']))
    bash.write('git_repo={}\n'.format(step['files']['git_repo']))
    bash.write('git_ref={}\n'.format(step['files']['git_ref']))

    yamlNestToBash(bash,'target_hosts',step['target_hosts'])
    yamlNestToBash(bash,'templates',step['files']['path']+step['files']['rollback'])
    yamlNestToAnsible(ansible,'sql_scripts',step['files']['path'])
    yamlNestToAnsible(ansible,'rollback_scripts',step['files']['rollback'])

def writeModuleWAR( step, path ):
    ansible = open(path+'/vars.yml','w')
    bash = open(path+'/vars.sh','w')

    bash.write('mdoule={}\n'.format(step['module']))
    yamlNestToBash(bash,'target_hosts',step['target_hosts'])
    yamlNestToAnsible(ansible,'nexus_download',step['nexus'])

def writeModuleConfig( step, path ):
    ansible = open(path+'/vars.yml','w')
    bash = open(path+'/vars.sh','w')

    bash.write('mdoule={}\n'.format(step['module']))
    bash.write('git_repo={}\n'.format(step['files']['git_repo']))
    bash.write('git_ref={}\n'.format(step['files']['git_ref']))

    yamlNestToBash(bash,'target_hosts',step['target_hosts'])
    yamlNestToBash(bash,'templates',step['files']['path'],sub='src')
    yamlNestToAnsible(ansible,'copy_files',step['files']['path'])

def generateStepVars( step, counter ):
    stepfolder = '{}/{}'.format(path,counter)
    try:
        os.stat(stepfolder)
    except:
        os.mkdir(stepfolder)

    logger.info("Parsing module {} - {}".format(counter,step['module']))

    if 'sql' in step['module']:
        writeModuleSQL(step,stepfolder)
    elif 'war' in step['module']:
        writeModuleWAR(step,stepfolder)
    elif 'configs' in step['module']:
        writeModuleConfig(step,stepfolder)

def parseInstructions( steps ):
    "Generate variable files to be sourced by ansible or fabricator"
    i = 1
    for step in steps:
        generateStepVars(step, i)
        i += 1

# execute

logger.info('Checking arguments')

if len(sys.argv) is not 2:
    die ("[ERROR] argument required! [input file path]")
else:
    filename=sys.argv[1]
path=os.path.dirname(os.path.realpath(sys.argv[0]))
infile='{}/{}'.format(path,filename)
logger.info('Input file: '+infile)

steps = readFileYAML( infile )
pp = pprint.PrettyPrinter(indent=4)
pp.pprint(steps)

parseInstructions(steps)
logger.info('Done.')
