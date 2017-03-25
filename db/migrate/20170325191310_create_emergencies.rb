class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.datetime :time
      t.string :link

      t.timestamps
    end
  end
end
