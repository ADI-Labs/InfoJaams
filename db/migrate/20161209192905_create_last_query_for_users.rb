class CreateLastQueryForUsers < ActiveRecord::Migration
  def change
    create_table :last_query_for_users do |t|
      t.text :last_query
    end
  end
end
