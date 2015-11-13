class CreateFhirs < ActiveRecord::Migration
  def change
    create_table :fhirs do |t|

      t.timestamps null: false
    end
  end
end
