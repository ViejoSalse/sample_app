require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Pagina de Inicio (Home)" do
    before { visit root_path}
    it {should have_content('Sample App')}
    it {should_not have_title('Sample App / Pagina de inicio')}

  end
  

  
  describe "Pagina de ayuda (Help)" do
    before {visit ayuda_path}
    it {should have_content('Help')}
    it {should have_title('Sample App / Pagina de ayuda')}

  end




  describe "Pagina Acerca de" do
    before{visit acerca_de_path}
    it {should have_content('Acerca de')}
    it {should have_title('Sample App / Pagina Acerca de')}

  end

  describe "Pagina de Contacto" do
    before{visit contacto_path}
    it {should have_content('Contacto')}
    it {should have_title('Sample App / Pagina de Contacto')}

  end

end
