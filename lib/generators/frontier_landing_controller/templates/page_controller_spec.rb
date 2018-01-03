require 'rails_helper'

describe <%= model.engine_name.camelize %>::PagesControllerSpec do

  describe 'GET landing' do
    subject { get :landing }

    it { is_expected.to render_template(:landing) }
  end

end
