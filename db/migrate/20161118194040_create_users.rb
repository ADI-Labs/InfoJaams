class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phonenumber
      t.text :last_query
      t.timestamps null: false
    end
    #rails generate migration CreateLastQueryForUsers
    #last_query :text
  end

end
