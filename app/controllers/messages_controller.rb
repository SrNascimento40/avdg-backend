class MessagesController < ApplicationController

    def index
        if params[:chat_id]
          messages = Message.where(chat_id: params[:chat_id]).order(created_at: :asc)
        elsif params[:legal_case_id]
          legal_case = LegalCase.find(params[:legal_case_id])
          messages = legal_case.messages
        else
          current_user = User.find(session[:user_id] || 3)
          messages = Message.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
        end
      
        render json: messages
    end

    def show
        legal_case = LegalCase.find(params[:legal_case_id])
        @message = legal_case.messages
        render json: @message
    end

    def create
        if params[:chat_id]
          chat = Chat.find(params[:chat_id])
          receiver_id = (chat.user_one_id == current_user.id) ? chat.user_two_id : chat.user_one_id
          legal_case_id = params.dig(:message, :legal_case_id)
      
          @message = Message.new(
            message_params.merge(
              sender_id: current_user.id,
              receiver_id: receiver_id,
              chat_id: chat.id,
              legal_case_id: legal_case_id
            )
          )
        else
          current_user = User.find(session[:user_id] || params[:message][:sender_id] || 1)
          receiver_id  = params[:message][:receiver_id]
          legal_case   = LegalCase.find_by(id: params[:message][:legal_case_id])
          chat = Chat.find_or_create_between(current_user.id, receiver_id)
      
          @message = Message.new(
            message_params.merge(
              sender_id: current_user,
              receiver_id: receiver_id,
              chat_id: chat.id,
              legal_case_id: legal_case&.id
            )
          )
        end

        if @message.save
          chat.update_column(:last_message_at, @message.created_at)
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
    end

    def update
        @message = Message.find(params[:id])
        if @message.update(message_params)
            render json: @message
        else
            render json: @message.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @message = Message.find(params[:id])
        @message.destroy
        head :no_content
    end

    def destroy_all
      if params[:chat_id]
        messages = Message.where(chat_id: params[:chat_id])
      elsif params[:legal_case_id]
        legal_case = LegalCase.find(params[:legal_case_id])
        messages = legal_case.messages
      else
        current_user = User.find(session[:user_id] || 3)
        messages = Message.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
      end

      messages.destroy_all
      head :no_content
    end

    private

    def message_params
        params.require(:message).permit(:content)
    end
end
