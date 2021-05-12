# CS514_WhereWasI

# Important Rules of Pushing Code to Codebase
**Git commit standardization**
`[type]: <subject><BLANK LINE><body><BLANK LINE>`

- All types list as follows：
    - feat: new feature
    - fix: bug fix
    - docs: docs modification. E.g. README, CHANGELOG, CONTRIBUTE, etc.
    - style: code style changes. E.g. line indent, no logical changes on code itself.
    - refactor: rewrite part of the code block，no new feature or bug fix
    - perf: impovment of user experience or system performance
    - test: testing, including unit test and intergrated test and UI test
    - chore: add library, dependencies or tools, change of workflow, or an otherwise menial task
    - revert: revert to previous version

**Git branch standardization**
- Basic rule:  master branch is protected ***Do not push to master in any cases*** 
    - If you work on something, e.g bug fix, new feature, check a new branch, when it's done, merge back into master
    - **Check and fix** your own conflict before merging back to master
    - branch type include `feature`, `bugfix`, `refactor`
    - name your branch start with type followed by type and detail. e.g `feature_03042021_NewUIofTodayView`
