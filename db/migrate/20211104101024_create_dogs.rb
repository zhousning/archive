class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    

    

    

    

    
      t.timestamps null: false
    end
  end
end
