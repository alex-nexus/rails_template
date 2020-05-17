* Configuration

* Database creation, migration, seed

```
rake reset
```

* How to run the test suite

#### Services (job queues, cache servers, search engines, etc.)
```
rake haml:erb2haml
```

* How to fork and get updates from upstream
https://stackoverflow.com/questions/3903817/pull-new-updates-from-original-github-repository-into-forked-github-repository?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

1. fork git@github.com:alex-nexus/rails_template.git
2. on github, rename the project to new app
3.
```
git clone git@github.com:alex-nexus/rails_template.git NEW_APP_NAME
```

4. rename
create a new repo
```
git clone git@github.com:alex-nexus/rails_template.git NEW_APP_NAME
```
remove entry "origin" in /.git/config
```
git remote add origin git@github.com:alex-nexus/bright_escrow.git
```

application.rb rename RailsTemplate to NEW_APP_NAME
database.yml rename template_ to new_app_name_

```
git push -u origin master
```

5. go to the forked repo
```
git remote add upstream git@github.com:alex-nexus/rails_template.git
git fetch upstream
git merge upstream/master
git push origin master
```

6. Good reference:
awesome-rails: https://github.com/gramantin/awesome-rails
zen-rails-security-checklist: https://github.com/brunofacca/zen-rails-security-checklist
Rails Best practice: https://rails-bestpractices.com/
