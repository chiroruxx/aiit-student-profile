# frozen_string_literal: true

# ErrorsController
class ErrorsController < ApplicationController
  layout 'full'

  def show
    @status_code = params[:code] || 500
    @message = message(@status_code)

    render 'default', status: @status_code
  end

  private

  def message(code)
    case code.to_i
    when 400
      '不正なリクエストです。'
    when 404
      'ページが見つかりません。'
    else
      'サーバエラーが発生しました。'
    end
  end
end
