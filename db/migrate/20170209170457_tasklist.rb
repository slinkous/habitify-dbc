class Tasklist < ActiveRecord::Migration
  def change
    create_table :taskslists do |t|
      t.datetime  :due_date

      t.timestamps
    end
  end
end
