class MessagesController < ApplicationController
    def index
        current_user = User.find(session[:user_id] || 3)

        if params[:legal_case_id]
            legal_case = LegalCase.find(params[:legal_case_id])
            messages = legal_case.messages
        else
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
        current_user = User.find(session[:user_id] || params[:message][:sender_id] || 1)
        receiver_id = params[:message][:receiver_id]
        
        if params[:message][:legal_case_id].present? && LegalCase.exists?(params[:message][:legal_case_id])
            legal_case = LegalCase.find(params[:message][:legal_case_id])
        end
        
        @message = Message.new(message_params.merge(
            sender_id: current_user,
            receiver_id: receiver_id,
            legal_case_id: legal_case.present? ? legal_case.id : nil
            ))
        @message.sender = current_user
        
        if @message.save
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

    private

    def message_params
        params.require(:message).permit(:content)
    end
end
