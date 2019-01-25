class ChangeScoresToDecimal < ActiveRecord::Migration
  def change
    change_column :ranks, :score_to, :decimal, precision: 3, scale: 1
    change_column :ranks, :score_from, :decimal, precision: 3, scale: 1
  end
end
