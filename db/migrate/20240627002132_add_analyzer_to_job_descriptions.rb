class AddAnalyzerToJobDescriptions < ActiveRecord::Migration[7.1]
  def change
    add_reference :job_descriptions, :analyzer, null: false, foreign_key: true
  end
end
