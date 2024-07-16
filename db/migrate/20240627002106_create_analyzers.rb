class CreateAnalyzers < ActiveRecord::Migration[7.1]
  def change
    create_table :analyzers do |t|

      t.timestamps
    end
  end
end
