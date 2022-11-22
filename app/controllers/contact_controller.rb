class ContactController < ApplicationController
  def new
    if SITE_CONFIG['display_contact_page']
      render 'contact/contact'
    else
      redirect_to root_url
    end
  end

  def create
    requests_service = RequestsService.new(request.user_agent)
    @result_message = requests_service.contact(contact_params.to_h)
    render partial: 'shared/form_result'
  end

  def contact_params
    params.permit(
      :name,
      :email,
      :phone,
      :question
    )
  end
end
