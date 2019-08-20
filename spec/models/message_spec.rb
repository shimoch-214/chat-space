require 'rails_helper'

RSpec.describe Message, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#create" do
    
    context "can be saved" do
      it "is valid with only body" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end

      it "is valid with only image" do
        message = build(:message, body: nil)
        expect(message).to be_valid
      end
      it "is valid with both of body and image" do
        message = build(:message)
        expect(message).to be_valid
      end
    end

    context "can't be saved" do
      it "is invalid without both of body and image" do
        message = build(:message, body: nil, image: nil)
        message.valid?
        expect(message.errors[:body]).to include("を入力してください")
      end

      it "is invalid without group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
      it "is invalid without user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
