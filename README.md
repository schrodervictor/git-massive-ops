# Git Massive Operation Scripts

These simple scripts were developed to automate some frequent operations for environments with multiple repositories and multiple projects.

Both scripts are supposed to be run on the parent directory of your repositories.

`clone-all.sh` helps to run the initial clone for all repos, based on a text file as a simple list. It'll create a directory for each project and a subdirectory for each repo. It takes care to pull all active branches and all tags for each repo.

```
$ ./clone-all.sh repo-list.txt
```

`copy-to-bitbucket.sh` helps the processs of copying several repos from your local environment to an remote destination on BitBucket, as a migration from one service provider to another or even as a backup plan. All repos are copied as private repos.

```
$ ./copy-to-bitbucket.sh repo-list.txt
```

The sample list of repos was designed thinking on the structure normally found on Atlassian Stash repositories (self hosted), but they can be easily ported or extended to suport other providers.

Any contribution is very wellcome! Just fork as usual and submit your pull request.


