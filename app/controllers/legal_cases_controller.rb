class LegalCasesController < ApplicationController

    def index
        @legal_cases = LegalCase.all
        render json: @legal_cases
    end

    def show
        @legal_case = LegalCase.find(params[:id])
        render json: @legal_case
    end

    def create
        legal_case = LegalCase.new(legal_case_params)
        legal_case.client = User.find(params[:legal_case][:client_id])
        legal_case.lawyer = User.find(params[:legal_case][:lawyer_id])
    
        if legal_case.save
            render json: legal_case, status: :created
        else
            render json: legal_case.errors, status: :unprocessable_entity
        end
    end

    def update
        @legal_case = LegalCase.find(params[:id])
        if @legal_case.update(legal_case_params)
            render json: @legal_case
        else
            render json: @legal_case.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @legal_case = LegalCase.find(params[:id])
        @legal_case.destroy
        head :no_content
    end

    private

    def legal_case_params
        params.require(:legal_case).permit(:title, :description, :status)
    end
end
