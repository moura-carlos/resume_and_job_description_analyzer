class AddAtsTipsToAnalyses < ActiveRecord::Migration[7.1]
  def change
    add_column :analyses, :ats_tips, :text
  end
end
