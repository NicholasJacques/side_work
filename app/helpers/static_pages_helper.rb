module StaticPagesHelper
  def render_header
    if current_user.class == Contractor
      render 'layouts/contractor_header'
    else
      render 'layouts/guest_header'
    end
  end
end
