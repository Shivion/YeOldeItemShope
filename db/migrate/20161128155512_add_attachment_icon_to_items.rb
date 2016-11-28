class AddAttachmentIconToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|

      t.attachment :icon

    end
  end

  def self.down

    remove_attachment :items, :icon

  end
end
