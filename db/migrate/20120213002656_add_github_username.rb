class AddGithubUsername < ActiveRecord::Migration
  def change
    add_column :orders, :github_username, :string
  end
end
