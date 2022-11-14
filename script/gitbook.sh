git checkout main
git add .
git commit -m $1
git push -u origin main
git checkout pages
cp -r _book/* .
git add .
git commit -m $1
git push -u origin pages
git checkout main