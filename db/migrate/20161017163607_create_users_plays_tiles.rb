class CreateUsersPlaysTiles < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
    end

    create_table :plays do |t|
      t.integer :user_id
      t.timestamps
    end

    create_table :tiles do |t|
      t.integer :play_id, null: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.timestamps
    end
  end
end
