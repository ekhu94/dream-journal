require_relative '../config/environment'

ActiveRecord::Migration.check_pending!

module JournalCLI
    
end

require_relative '../app/models/person.rb'
require_relative '../app/models/dream.rb'
require_relative '../app/models/entry.rb'