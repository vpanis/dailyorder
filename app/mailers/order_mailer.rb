class OrderMailer < ApplicationMailer
  def send_orders(supplier_id, orders_ids, document_id)
    @supplier = Supplier.find(supplier_id.id)
    @orders = orders_ids.map { |order_id| Order.find(order_id.id) }
    @document = Document.find(document_id.id)

    attachments["rc_#{@document.created_at.strftime("%d_%m_%Y")}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: 'rc_#{@document.created_at.strftime("%d_%m_%Y")}.pdf',
        template: 'rc.pdf.erb')
    )

    mail(
      to:       @supplier.email,
      subject:  "DailyOrder : #{@document.title}"
    )
  end
end
