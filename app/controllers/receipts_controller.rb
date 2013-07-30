class ReceiptsController < ApplicationController
  def create
    @receipt = params[:file].present? ? Receipt.analyse(params[:file].read) : Receipt.new(params)
    
    respond_to do |format|
      if @receipt.save
        format.html { redirect_to edit_receipt_path(@receipt), notice: 'Receipt was successfully created.' }
        format.json { render action: 'scan'}
      else
        format.html { render action: 'new' }
      end
    end
  end
end
