class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :terms
      t.string :reward
      t.datetime :end_date
      t.integer :challenger_id
      t.integer :challengee_id
      t.integer :winner_id
      t.integer :status_id
      t.string :bitly_url

      t.timestamps
    end
  end
end
