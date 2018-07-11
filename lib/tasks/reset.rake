desc 'Reset'
task :reset do
  sh('rake db:environment:set')
  sh('rake db:drop')
  sh('rake db:create')
  sh('rake db:migrate')
  sh('rake db:test:prepare')
  sh('rake db:structure:dump')
  sh('bundle exec annotate -i')
  sh('bundle exec erd')
  sh('rake db:seed')
end
