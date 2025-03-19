class MessagesController < ApplicationController
    def index
        @messages = Message.all
        render json: @messages
    end

    def show
        @message = Message.find(params[:id])
        render json: @message
    end

    def create
        legal_case = LegalCase.find(params[:legal_case_id])
        current_user = 1 # gamb pra rodar, depois mudar para current_user.id
        receiver_id = current_user != legal_case.client_id ? legal_case.client_id : legal_case.lawyer_id
        @message = Message.new(message_params.merge(
            sender_id: current_user,
            receiver_id: receiver_id,
            legal_case_id: legal_case.id
        ))
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
