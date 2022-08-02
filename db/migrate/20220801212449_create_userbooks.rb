class CreateUserbooks < ActiveRecord::Migration[7.0]
  def change
    create_table :userbooks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :issue_date
      t.timestamps
    end
  end
end
