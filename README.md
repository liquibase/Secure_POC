<p align="left">
  <img src="img/liquibase.png" alt="Liquibase Logo" title="Liquibase Logo" width="324" height="72">
</p>

# Welcome to Liquibase!
This repository contains links to documentation, sample files, and tips for evaluating Liquibase. This evaluation is intended for people interested in learning about the capabilities of Liquibase Pro.

Liquibase Pro enables best practices that are designed to remove friction from the flow of changes to databases. These practices ensure speed, quality, and governance within the change process.

## Liquibase Documentation
* [Documentation Home](https://docs.liquibase.com/home.html)
* [Liquibase University](https://learn.liquibase.com/)
* [Liquibase Forums](https://forum.liquibase.org/)

## Installing Liquibase
Liquibase can be installed locally (e.g., on a workstation or automation tool agent/runner) or invoked using our [official Docker image](https://hub.docker.com/_/liquibase).

Liquibase can be downloaded for Windows, Max, and Linux platforms [here](https://www.liquibase.com/download).

To apply your Pro license key, check [here](https://docs.liquibase.com/liquibase-pro/license-key.html).


## Core Concepts
If you are unfamilar with Liquibase concepts, here is some information to get you started.

* [Changeset](https://docs.liquibase.com/concepts/changelogs/changeset.html): basic unit of database work
* [Changelog](https://docs.liquibase.com/concepts/changelogs/home.html): text file containing collection of changesets
* [Tracking tables](https://docs.liquibase.com/concepts/tracking-tables/tracking-tables.html): tables created and maintained by Liquibase

Changelog formats can be mixed and matched as desired. Liquibase does not impose any file name requirements.

## Sample Changelogs

* [Root - Mongo](changelog.mongo.xml)
    * [JS - Mongo](changesets/changelog.mongo.js)
* [Root - SQL](changelog.relational.sql)
    * [SQL - Relational](changesets/changelog.ddl.sql)
* [Root - XML](changelog.relational.xml)
    * [XML - Relational](changesets/changelog.ddl.xml)

```
Tree
│   changelog.mongo.xml
│   changelog.relational.sql
│   changelog.relational.xml
│
├───changesets
│       changelog.ddl.sql
│       changelog.ddl.xml
│       changelog.mongo.js
```

## Database Connections
Liquibase supports over [60 databases](https://www.liquibase.com/supported-databases), including data warehouses, relational, and NoSQL.

A [liquibase.properties](https://docs.liquibase.com/concepts/connections/creating-config-properties.html) file can be used for basic testing. However, it is **strongly** recommended that [environment variables](https://docs.liquibase.com/concepts/connections/liquibase-environment-variables.html) or a [secrets manager extension](https://docs.liquibase.com/liquibase-pro/secrets-management/home.html) be used for any scenario beyond that.

In general, Liquibase needs three pieces of information to connect to a database.

1. [JDBC URL](https://docs.liquibase.com/workflows/liquibase-community/using-jdbc-url-in-liquibase.html): database connection string
1. Username: typically a service account
1. Password: typically stored within a vault

The exact information required may vary between individual database platforms. Consult [the database documentation](https://www.liquibase.com/supported-databases) for specific details.

## Helpful Liquibase Commands
|Command |Description|Documentation
|----------|------------|------------|
| connect | Test database connection | [Link](https://docs.liquibase.com/commands/change-tracking/connect.html)
| status | Show undeployed changes | [Link](https://docs.liquibase.com/commands/change-tracking/status.html)
| update | Run changes against target database | [Link](https://docs.liquibase.com/change-types/update.html)
| history | Show deployed changes | [Link](https://docs.liquibase.com/commands/change-tracking/history.html)
| rollback-one-update | Rollback the last or a specified update | [Link](https://docs.liquibase.com/commands/rollback/rollback-one-update.html)
| checks | Show or view policy checks | [Link](https://docs.liquibase.com/liquibase-pro/policy-checks/workflows/home.html)
| flow | Execute a Liquibase workflow | [Link](https://docs.liquibase.com/commands/flow/flow.html)

## Liquibase in Automation
Liquibase Pro can work with any automation tool which supports invoking command-line tools. Liquibase provides working examples for some popular automation platforms.

* [Azure Dev Ops](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/ADO/azure_pipelines_docker.yml) (build)
* [Ansible Tower](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/Ansible_Tower/liquibase_playbook.yml
)
* [AWS CodeBuild](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/CodeBuild/buildspec.yml)
* [Bitbucket Pipelines](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/Bitbucket/bitbucket-pipelines.yml)
* [CircleCI](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/CircleCI/config.yml)
* [GitHub Actions](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/GitHub_Actions/liquibase_workflow.yml)
* [GitLab](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/GitLab_CICD_Pipelines/gitlab-ci.yml)
* [Jenkins](https://github.com/liquibase/liquibase-toolbox/blob/master/build_scripts_examples/Jenkins/Jenkinsfile)

## Core Pro Features
During a typical evaluation the following features are exercised.

1. [Policy Checks](https://docs.liquibase.com/liquibase-pro/policy-checks/home.html): similar to static code analysis, but geared more for database changes
1. [Workflows](https://docs.liquibase.com/commands/flow/flow.html): portable, database independent workflows to ensure consistency
1. [Targeted Rollback](https://docs.liquibase.com/liquibase-pro/targeted-rollbacks.html): rollback individual changesets
1. [Operation Reports](https://docs.liquibase.com/liquibase-pro/observability/operation-reports.html): basic HTML reports used for auditing or troubleshooting
1. [Structured Logging](https://docs.liquibase.com/liquibase-pro/observability/structured-logging.html): JSON formatted logs to feed into an observability tool for reporting (e.g., Datadog, Splunk, Grafana)

Sample flow files are included in this repository.

* [liquibase.flowfile.base.yaml](liquibase.flowfile.base.yaml): sample flow containing common commands
* [liquibase.flowfile.ci.yaml](liquibase.flowfile.ci.yaml): sample flow for Continuous Integration
* [liquibase.flowfile.cd.yaml](liquibase.flowfile.cd.yaml): sample flow for Continuous Delievery

## Contact Liquibase
* Liquibase sales: https://www.liquibase.com/contact
* Liquibase support: https://support.liquibase.com/

# Thank you!
Thank you for evaluating Liquibase Pro! We hope to be a part of your DevOps journey.