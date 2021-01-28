
# Dream Journal
Dream Journal is a command line application where a user can submit journal entries and track the patterns of their dreams. The user has the option to categorize their dreams (EX: nightmare) and whether a dream is recurring as well as how many hours they slept. The user can read prior entries, update, and delete any of their past dream entries. 

## Getting started with Gems
gem "pry", "~> 0.12.2"
gem "activerecord", "~> 6.0"
gem "sinatra-activerecord", "~> 2.0"
gem "rake", "~> 13.0"
gem "sqlite3", "~> 1.4"
gem "require_all", "~> 3.0"

## Executing program
Fork and clone the CLI Dream Journal App repo
```bash
Run bundle install
Run rake db:migrate
Run rake db:seed
Run ruby bin/run.rb
```

## Contributing
For major changes, please open an issue first to discuss what you would like to change. Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
``` -->
