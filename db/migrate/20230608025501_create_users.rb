class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, :null => false, :uniqueness => true
      t.string :email, :null => false, :uniqueness => true
      t.timestamps
    end
  end
end
