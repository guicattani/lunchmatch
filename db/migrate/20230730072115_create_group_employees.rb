class CreateGroupEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :group_employees do |t|
      t.references :group, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.boolean :leader, null: false, default: false

      t.timestamps
    end
  end
end
