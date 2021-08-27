
# Requires pysemver (pipx install semver)
function git-semver-bump (){
   if [ ! -z $1 ]
      then
         pysemver bump $1 $(git tag -l |sort |tail -n1)
      else
         echo "USAGE: semver-bump [major|minor|patch]"
   fi
}
