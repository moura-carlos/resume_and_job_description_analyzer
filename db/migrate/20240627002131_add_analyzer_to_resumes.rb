class AddAnalyzerToResumes < ActiveRecord::Migration[7.1]
  def change
    add_reference :resumes, :analyzer, null: false, foreign_key: true
  end
end
