class CreateUserFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :user_follows, primary_key: [:follower_id, :following_id] do |t|
      t.integer :follower_id
      t.integer :following_id
    end

    add_foreign_key :user_follows, :users, column: :follower_id
    add_foreign_key :user_follows, :users, column: :following_id
  end
end
