# This migration comes from bx_block_link_share (originally 20211129075315)
class CreateBxBlockLinkShareFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_link_share_files do |t|
      t.bigint :social_media_share_id
      t.string :file_url

      t.timestamps
    end
  end
end
