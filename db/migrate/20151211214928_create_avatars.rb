class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string    :name
      t.string    :meta_data
      t.string    :original_url
      t.string    :profile_url
      t.string    :nav_url
      t.integer   :user_id
      t.index     :user_id

      t.timestamps null: false
    end
  end
end
