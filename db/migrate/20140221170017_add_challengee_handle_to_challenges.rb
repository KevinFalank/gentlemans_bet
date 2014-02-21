class AddChallengeeHandleToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :challengee_handle, :string
  end
end
