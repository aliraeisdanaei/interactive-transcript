class TranslateController < ApplicationController
  skip_before_action :verify_authenticity_token

  def translate
    respond_to do |format|
      format.json do
        translated_text = Translator.translate_from_key(params[:key])

        render json: { text: translated_text }
      end
    end
  end

  rescue_from Translator::Error do |error|
    Rollbar.error(error)
    render json: { error: { message: "Translation failed" } }, status: 500
  end
end
