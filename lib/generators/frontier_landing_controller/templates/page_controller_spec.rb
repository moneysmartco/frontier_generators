require 'rails_helper'

describe <%= controller_name %> do

  describe 'GET landing' do
    subject { :get, :landing }

    it { is_expected.to render_template(:landing) }
  end

end
