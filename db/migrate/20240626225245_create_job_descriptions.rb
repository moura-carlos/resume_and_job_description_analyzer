class CreateJobDescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :job_descriptions do |t|
      t.text :content

      t.timestamps
    end
  end
end
