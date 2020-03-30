class CreateDns < ActiveRecord::Migration[6.0]
  def change
    create_table :dns do |t|
    	t.string :ip
    	t.string :hostnames, array: true, default: []
      t.timestamps
    end
  end
end
