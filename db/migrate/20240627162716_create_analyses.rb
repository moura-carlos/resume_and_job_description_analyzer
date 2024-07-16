class CreateAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :analyses do |t|
      t.text :content
      t.references :analyzer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
