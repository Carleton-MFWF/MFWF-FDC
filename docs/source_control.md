# Git Workflow
## Create a new feature branch
- To get started open the .prj file in MATLAB and click on branches in the source control section of the project ribbon.
- Make sure you are on the up to date main branch. To do this switch the main branch and do a pull or fetch.
- Once your main branch is up to date, open the branches again and click on "Brand and Tag Creation"
- Enter the name of your branch as `[feature name]_[your name]`. Example `rotation_matrices_nabil`.
- Once your branch is created, select it in the drop down menu and click switch.

## Work on feature
- Modify or add files and make commits when sections are complete
- If there are any other changes made by others on the main branch you can merge the main branch into your branch at anytime.
- Once your feature is complete and ready to be added to the main project make sure to merge the main branch one last time and resolve any merge conflicts.

## Pull Request
- Once your branch is ready, make a pull request on github and add other members of the group as reviewers.
- Other members will look over the code and make comments on anything that should be changed. example variable names or logic.
- During this stage double check the files you have modified and make sure nothing was accidentally committed.
- Once all members approve of the pull request, the pull request can be completed which will merge the feature branch into main.
- Make sure to delete your feature branch afterwards to keep repo tidy.

# Resources
https://www.mathworks.com/help/matlab/source-control.html
https://guides.github.com/introduction/git-handbook/
https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
