require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:group)       { create(:group) }
  let(:user)        { create(:user)}
  
  describe "GET #index" do
    context "when signed in" do
      before do
        sign_in user
        get :index, params: {group_id: group.id}
      end
      
      it "renders the :index template" do
        expect(response).to render_template :index
      end

      it "assigns the selected group to @group" do
        expect(assigns(:group)).to eq group
      end
    
      it "assigns a empty message to @new_message" do
        expect(assigns(:new_message)).to be_a_new Message
      end
    
      it "assigns messsages sorted by created_at asc to @messages" do
        messages = create_list(:message, 5, group_id: group.id).sort{ |a, b| a.created_at <=> b.created_at }
        expect(assigns(:messages)).to match(messages)
      end

    end
    context "when not signed in" do
      before do
        get :index, params: {group_id: group.id}
      end

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    let(:valid_params)          {{group_id: group.id, 
                                  user_id:  user.id,
                                  message:  attributes_for(:message)
    }}

    let(:invalid_params)        {{group_id: group.id,
                                  user_id:  user.id,
                                  message:  attributes_for(:message, body: nil, image: nil)
    }}

    context "when signed in" do
      before do
        sign_in user
      end

      context "the posting was successed" do
        before do
          post :create, params: valid_params
        end

        it "umaikotoitta" do
          expect{post :create, params: valid_params}.to change(Message, :count).by(1)
        end
        it "redirect to group_messages_path" do
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context "the posting was failed" do
        before do
          post :create, params: invalid_params
        end

        it "umakuikannkatta" do
          expect{post :create, params: invalid_params}.to change(Message, :count).by(0)
        end
        it "renders index" do
          expect(response).to render_template :index
        end
      end
    end

    context "when not signed in" do
      before do
        post :create, params: invalid_params
      end
      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
