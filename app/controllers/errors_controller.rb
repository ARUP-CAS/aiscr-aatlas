class ErrorsController < ApplicationController
  
  def page404
    @title = I18n.t("meta.error_404.title")
    @line1 = I18n.t("meta.error_404.text_line_1")
    @line2 = I18n.t("meta.error_404.text_line_2")
    
    render "errors/show"
  end
  
  def page422
    @title = I18n.t("meta.error_422.title")
    @line1 = I18n.t("meta.error_422.text_line_1")
    @line2 = I18n.t("meta.error_422.text_line_2")
    
    render "errors/show"
  end
  
  def page500
    @title = I18n.t("meta.error_500.title")
    @line1 = I18n.t("meta.error_500.text_line_1")
    @line2 = I18n.t("meta.error_500.text_line_2")
    
    render "errors/show"
  end
  
end
