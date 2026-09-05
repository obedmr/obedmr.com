# Build the project.
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
hugo

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="Update site `date`"
if [ $# -eq 1 ]
then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git checkout master
git merge HEAD@{1}
git push

# Come Back up to the Project Root
cd ..

# Update submodule
git add public
git commit -s -m "Update public submodule"
