#!/bin/bash

available_files=$(git status -uall --porcelain \
    | grep -e "^ M " -e "^ D " -e "^R " -e "^RM ")

available_files_names=$(echo "$available_files" \
    | sed -e 's/^\( M\| D\|R \|RM \) //' \
    | sed -E 's/(^.*\s)//g' \
    | egrep ".*")


available_files_found=$(echo "$available_files" | wc -l)
if [ "$available_files_found" -eq "1" ]; then
    files_added=$available_files_names
else
    files_added=$(echo "$available_files_names" | fzf -m | tr '\n' ' ')
fi

[[ -z "$files_added" ]] && exit

echo "$files_added" | xargs git add

file_added=$(echo "$files_added" | awk '{print $1}')

file_added_original_name=$(echo $available_files | awk -v pattern=$file_added '$0 ~ pattern {print $2}')

current_branch=$(git branch | awk '/^*/ {print $2} ')

commits=$(sort <(git log --oneline --follow -- "$file_added_original_name") <(git log --oneline $(git merge-base develop "$current_branch")..HEAD) | uniq -d)

commits_found=$(echo "$commits" | wc -l)

if [ "$commits_found" -eq "1" ]; then
    commit="$commits"
else
    commit=$(echo "$commits" | fzf)
fi

commit_hash=$(echo "$commit" | awk '{print $1}')

REV=$(git rev-parse $commit_hash) && git commit --fixup $commit_hash

stash_changes=$(git stash)

git rebase -i --autosquash $REV^

[[ "$stash_changes" != "No local changes to save" ]] && git stash apply > /dev/null
