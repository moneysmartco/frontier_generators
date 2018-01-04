require 'rails_helper'

describe '<%= model.engine_name.camelize %>::PagesController routing' do
  routes { <%= model.engine_name.camelize %>::Engine.routes }

  subject { get :landing }
  it 'routes pages#landing as expected' do
    expect(subject).to route_to(
      controller: '<%= model.engine_name %>/pages',
      action: 'landing'
    )
  end
end
