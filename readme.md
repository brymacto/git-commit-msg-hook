## Commit Message Hook Script

* Validates that commit message starts with `#XXX` where `XXX` is a number from the working branch name.  Commits that fail the validation are aborted.
* This script was created for a particular gitflow so it may need to be modified for other teams.  The ticket number is at least 4 digits and is always at the beginning of the branch name.
* `--no-validate` option allows user to bypass validation.
* If current branch name does not start with a number, the commit is not aborted regardless of the commit message. 
  
### Instructions
1. Copy `commit-message.rb` to your repository's directory: `./.git/hooks/`
2. Remove the `.rb` extension
3. `chmod +x commit-msg`