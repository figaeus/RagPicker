require 'spec_helper'

describe 'home/index' do
  it 'displays project tagline' do
    render
    expect(rendered).to include('A refreshingly simple approach towards Web Clipping and Annotation.')
  end
end
