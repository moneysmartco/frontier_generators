class Frontier::ControllerSpec::NewAction < Frontier::ControllerSpec::CollectionAction

  def to_s
    raw = <<STRING
describe 'GET new' do
#{render_with_indent(1, render_setup)}

  authenticated_as(:admin) do
    it { is_expected.to render_template(:new) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model, :get, :new).to_s
  end

end
