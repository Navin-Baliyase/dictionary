class CreateIcicles < ActiveRecord::Migration[5.2]
  def change
    create_table :icicles do |t|
      t.integer :phone

      t.timestamps
    end
  end
end
