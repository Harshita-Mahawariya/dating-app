# frozen_string_literal: true
# This migration comes from bx_block_link_share (originally 20210319071837)

class CreateBxBlockLinkShareSocialMediaShares < ActiveRecord::Migration[6.0]
  def change
    create_table :social_media_shares do |t|
      t.bigint :account_id
      t.bigint :product_id
      t.timestamps
    end
  end
end
