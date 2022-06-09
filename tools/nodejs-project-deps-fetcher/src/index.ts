import _ from 'the-lodash';
import * as fs from 'fs';
import * as Path from 'path';
import { table } from 'table';


import {
    UI_MODULES,
    UI_MODULE_DEPS_DELETE,
    UI_MODULE_DEPS,
    UI_MODULE_DEV_DEPS,
    UI_MODULE_RESOLUTIONS,
} from './metadata';

let DEPS_MATRIX : Record<string, Record<string, { version: string, isDev: boolean } > > = {};

type ProjectVisitHandler = (name: string, project: any) => void;

function visitProject(name: string, handler: ProjectVisitHandler)
{
    console.log("*****");
    console.log("***** MODULE: ", name);
    console.log("*****");

    const projectData = getPackageData(name);
    handler(name, projectData);
}

function visitProjects(names: string[], handler: ProjectVisitHandler)
{
    for(const name of names)
    {
        visitProject(name, handler);
    }
}

function getProjectRoot(name: string)
{
    return Path.resolve(`${name}.git`);
}

function getPackagePath(name: string)
{
    return Path.resolve(getProjectRoot(name), 'package.json');
}

function getPackageData(name: string)
{
    const contents = fs.readFileSync(getPackagePath(name), 'utf8');
    return JSON.parse(contents);
}

function savePackageData(name: string, packageData: any)
{
    const contents = JSON.stringify(packageData, null, 4);
    fs.writeFileSync(getPackagePath(name), contents, 'utf8');
}

function registerDependency(name: string, dep: string, version: string, isDev: boolean)
{
    // console.log("    > ", dep , ' -> ', version, ' :: isDev: ', isDev);

    if (!DEPS_MATRIX[dep]) {
        DEPS_MATRIX[dep] = {};
    }
    DEPS_MATRIX[dep][name] = {
        version: version,
        isDev: isDev
    };
}

function loadDependencies(name: string, projectData: any)
{
    // console.log("[loadDependencies] %s :: ", name, projectData);
    for(const dep of _.keys(projectData.dependencies ?? {}))
    {
        registerDependency(name, dep, projectData.dependencies[dep], false);
    }

    for(const dep of _.keys(projectData.devDependencies ?? {}))
    {
        registerDependency(name, dep, projectData.devDependencies[dep], true);
    }
}

function processProjectData(name: string, projectData: any)
{
    loadDependencies(name, projectData);
}

function outputMatrix()
{
    const depsNames = _.keys(DEPS_MATRIX).sort();

    const tableData : string[][] = [];

    tableData.push(["Dependency", "Sync", ...UI_MODULES]);

    for(const dep of depsNames)
    {
        const row = UI_MODULES.map(name => {

            const usage = DEPS_MATRIX[dep][name];
            if (usage) {
                if (usage.isDev) {
                    return `${usage.version} (DEV)`;
                }
                return `${usage.version}`;
            }

            return '';

        });

        const uniqueVersions = _.makeDict(row, x => x, x => true);

        const inSync = (_.keys(uniqueVersions).length <= 1);

        tableData.push([
            dep,
            inSync? "✅" : "❌",
            ...row]);
    }

    console.log(table(tableData));
    
}

function fixUIModuleDependency(name: string, projectData: any)
{
    if (!projectData.dependencies) {
        projectData.dependencies = {};
    }
    if (!projectData.devDependencies) {
        projectData.devDependencies = {};
    }
    if (!projectData.resolutions) {
        projectData.resolutions = {};
    }

    for(const dep of UI_MODULE_DEPS_DELETE)
    {
        delete projectData.dependencies[dep];
        delete projectData.devDependencies[dep];
    }
    for(const dep of _.keys(UI_MODULE_DEPS))
    {
        const version = UI_MODULE_DEPS[dep];
        delete projectData.devDependencies[dep];
        if (projectData.dependencies[dep] !== version) {
            projectData.dependencies[dep] = version;
        }
    }
    for(const dep of _.keys(UI_MODULE_DEV_DEPS))
    {
        const version = UI_MODULE_DEV_DEPS[dep];
        delete projectData.dependencies[dep];
        if (projectData.devDependencies[dep] !== version) {
            projectData.devDependencies[dep] = version;
        }
    }

    for(const dep of UI_MODULE_RESOLUTIONS)
    {
        let version = UI_MODULE_DEPS[dep];
        if (!version) {
            version = UI_MODULE_DEV_DEPS[dep];
        }
        if (!version) {
            throw new Error(`Version is not set for ${dep}`);            
        }
        projectData.resolutions[dep] = version;
    }

    savePackageData(name, projectData);

    copyDataFile(name, 'data/ui-module/tsconfig.json');
    copyDataFile(name, 'data/ui-module/rollup.config.js');
    copyDataFile(name, 'data/ui-module/jest.config.ts');
    copyDataFile(name, 'data/ui-module/.eslintrc.yml');

    deleteProjectFile(name, 'jest.config.js');
}

function copyDataFile(projectName: string, dataFilePath: string)
{
    console.log("[copyDataFile] project: ", projectName, ' Data File: ', dataFilePath);

    const projectRootPath = getProjectRoot(projectName);
    const destPath = Path.resolve(projectRootPath, Path.parse(dataFilePath).base);
    console.log("[copyDataFile] dest: ", destPath);

    const sourcePath = Path.resolve('workspace.git/tools/nodejs-project-deps-fetcher', dataFilePath);
    console.log("[copyDataFile] source: ", sourcePath);

    console.log("[copyDataFile] ", sourcePath, " -> ", destPath);

    fs.copyFileSync(sourcePath, destPath);
}

function deleteProjectFile(projectName: string, projectFilePath: string)
{
    console.log("[deleteProjectFile] project: ", projectName, ' Project File: ', projectFilePath);

    const projectRootPath = getProjectRoot(projectName);

    const fullPath = Path.resolve(projectRootPath, projectFilePath);
    console.log("[deleteProjectFile] path: ", fullPath);

    if (fs.existsSync(fullPath))
    {
        fs.rmSync(fullPath);
    }    
}

/*****************************************************************/


function execute()
{
    const myArgs = process.argv.slice(2);
    console.log(myArgs);
    
    if (myArgs[0] == 'output-matrix') {
        visitProjects(UI_MODULES, processProjectData);
        outputMatrix();
        return;
    }
    if (myArgs[0] == 'fix-ui-deps') {

        DEPS_MATRIX = {};
        visitProjects(UI_MODULES, processProjectData);
        console.log("***** BEFORE *****")
        outputMatrix();

        DEPS_MATRIX = {};
        visitProjects(UI_MODULES, fixUIModuleDependency)

        DEPS_MATRIX = {};
        visitProjects(UI_MODULES, processProjectData);
        console.log("***** AFTER *****")
        outputMatrix();
        return;
    }
    
    console.error("UNKNOWN ARGUMENTS: ", myArgs);
}


execute();
