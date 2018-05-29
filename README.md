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

1. fork git@github.com:alex-nexus/rails_template.git
2. on github, rename the project to new app
3.
```
git clone git@github.com:alex-nexus/rails_template.git NEW_APP_NAME
```

4. rename
application.rb rename RailsTemplate to NEW_APP_NAME
database.yal rename template_ to new_app_name_

5. go to the forked repo
```
git remote add upstream git@github.com:alex-nexus/rails_template.git
git fetch upstream      
git merge upstream/master
git push origin master
```
