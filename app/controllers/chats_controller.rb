class ChatsController < ApplicationController
    before_action :authenticate_user!

    def index
      chats = Chat.for_user(current_user.id).order(last_message_at: :desc)

      chats = chats.map do |chat|
        other_user = chat.users.find { |user| user.id != current_user.id }
        if other_user.nil?
          chat.destroy
        else
          chat.as_json.merge(name: other_user.name)
        end
      end
      chats.compact! # Remove chats that were destroyed
      render json: chats
    end

    def show
      chat = Chat.find(params[:id])
      render json: chat
    end

    def create
      receiver_id = params.require(:receiver_id)
      chat = Chat.find_or_create_between(current_user.id, receiver_id)
      render json: chat, status: :created
    end
end
