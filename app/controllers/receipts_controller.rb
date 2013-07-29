class ReceiptsController < ApplicationController

  def scan
    @receipt = Receipt.analyse(params[:file].read)
  end
end
