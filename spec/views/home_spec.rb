require 'spec_helper'

describe 'home/index' do
  it 'displays project tagline' do
    allow(view).to receive(:logged_in?).and_return false
    render
    expect(rendered).to include('A refreshingly simple approach towards Web Clipping and Annotation.')
  end
end
