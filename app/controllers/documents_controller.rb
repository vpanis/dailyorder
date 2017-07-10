class DocumentsController < ApplicationController

  def show
    @document = Document.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @relation = Relation.find(params[:relation_id])
    @order = @document.order
    authorize @document

    if @document.document_type == "Bon de commande"
      respond_to do |format|
        format.pdf do
          render pdf: "bc.pdf",
                 template: "documents/bc.pdf.erb"
        end
      end
    elsif @document.document_type == "Bon de livraison"
      respond_to do |format|
        format.pdf do
          render pdf: "bl.pdf",
                 template: "documents/bl.pdf.erb"
        end
      end
    elsif @document.document_type == "Facture"
      respond_to do |format|
        format.pdf do
          render pdf: "f.pdf",
                 template: "documents/f.pdf.erb"
        end
      end
    elsif @document.document_type == "Relevé de factures"
      respond_to do |format|
        format.pdf do
          render pdf: "rf.pdf",
                 template: "documents/rf.pdf.erb"
        end
      end
    end
  end
end
