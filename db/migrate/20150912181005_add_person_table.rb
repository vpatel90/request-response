class AddPersonTable < ActiveRecord::Migration
    def change
      create_table(:people) do |t|
        t.string :name
        t.string :age
      end
    end
end
