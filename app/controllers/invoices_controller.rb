class InvoicesController < ApplicationController
    def index
      render json: Invoice.all
    end
  
    def show
      invoice = Invoice.find(params[:id])
      render json: invoice
    end
  
    def create
      invoice = Invoice.new(invoice_params)
      if invoice.save
        render json: invoice, status: :created
      else
        render json: invoice.errors, status: :unprocessable_entity
      end
    end
  
    def update
      invoice = Invoice.find(params[:id])
      if invoice.update(invoice_params)
        render json: invoice
      else
        render json: invoice.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      invoice = Invoice.find(params[:id])
      invoice.destroy
      head :no_content
    end
  
    private
  
    def invoice_params
      params.require(:invoice).permit!
    end
  end
  