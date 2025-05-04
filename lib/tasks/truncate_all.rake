namespace :db do
    desc "Truncate all tables in production"
    task truncate_all: :environment do
      raise "This task only runs in production!" unless Rails.env.production?
  
      puts "⚠️ Truncating all tables in production..."
  
      connection = ActiveRecord::Base.connection
  
      tables = ActiveRecord::Base.connection.tables - ["schema_migrations", "ar_internal_metadata"]
      tables.each do |table|
        connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
        puts "✅ Truncated #{table}"
      end
  
      puts "🎉 All user data cleared (production)"
    end
  end
  