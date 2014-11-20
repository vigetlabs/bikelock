class AddLockFieldsToText < ActiveRecord::Migration
  def change
    add_column :texts, :locked, :boolean, default: false
    rename_column :texts, :body, :lock_phrase
  end
end
