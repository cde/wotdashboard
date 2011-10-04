class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, :null => false, :default => false
    
    User.create(email: 'admin@gmail.com', username: 'admin', password: 'abc12345@', admin: true)
    User.create(email: 'user@gmail.com', username: 'user', password: 'abc12345@')
  end
end
