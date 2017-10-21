module StaticPagesHelper
  def render_header
    if current_user
      if current_user.contractor?
        render 'layouts/contractor_header'
      else 
        render 'layouts/restaurant_header'
      end
    else
      render 'layouts/guest_header'
    end
  end
end
