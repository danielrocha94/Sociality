class AddReplyToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_reply, :boolean, default: false
    add_column :comments, :reply_of, :integer
  end
end
