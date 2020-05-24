class AddLikesCountToLogs < ActiveRecord::Migration[5.2]
  # class MigrationUser < ApplicationRecord
  #   self.table_name = :logs
  # end
  def change
    add_column :logs, :likes_count, :integer, null: false, default: 0 unless column_exists? :logs, :likes_count
  end
end
