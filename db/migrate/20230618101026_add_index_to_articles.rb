class AddIndexToArticles < ActiveRecord::Migration[6.1]
  def change
    add_index :articles, :created_at
  end
end
