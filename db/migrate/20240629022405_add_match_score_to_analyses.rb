class AddMatchScoreToAnalyses < ActiveRecord::Migration[7.1]
  def change
    add_column :analyses, :match_score, :decimal
  end
end
