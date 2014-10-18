require 'spec_helper'

describe User do
  before { @user = User.new(name: "Usuario Ejemplo", email: "usuario@prueba.com", password: "clave123", password_confirmation: "clave123" ) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
  describe "cuando el nombre no este presente" do

  	before { @user.name =" " }
  	it { should_not be_valid }
  end


  describe "cuando el mail no este presente" do

  	before { @user.email =" " }
  	it { should_not be_valid }
  end

  describe "cuando el nombre es muy largo" do

  	before { @user.name ="a" * 51 }
  	it { should_not be_valid }
  end

  describe "cuando el formato de email es invalido" do
  	it "debe ser invalido" do
  		direcciones = %w[user@prueba,com usuario_numero_.org usuario@prueba.comusuario@prueba.com usuario@prueba+com]	
  		direcciones.each do |direccion_invalida|
  			@user.email = direccion_invalida
  			expect(@user).not_to be_valid
  		end
  	end
  end




describe "cuando el formato de email es valido" do
  	it "debe ser invalido" do
  		direcciones = %w[user@prueba.COM A_US_ER@prueba.org.ec usuario.uno@prueba.ec]	
  		direcciones.each do |direccion_valida|
  			@user.email = direccion_valida
  			expect(@user).to be_valid
  		end
  	end
  end

describe "cuando el email ya exista" do
	before do
		usuario_con_el_mismo_email = @user.dup
		usuario_con_el_mismo_email.email = @user.email.upcase
		usuario_con_el_mismo_email.save
	end
	it { should_not be_valid}
end

describe "cuando el password no está presente" do
	before do
		@user = User.new(name: "Usuario Ejemplo",  email: "usuario@prueba.com", password: " ", password_confirmation: " ")
	end
	it { should_not be_valid }
end

describe "cuando el password no es igual" do
	before { @user.password_confirmation = "missmatch" }
		it { should_not be_valid }

end
describe "cuando el password es muy corto " do
	before { @user.password = @user.password_confirmation = "a" * 5}
	it { should be_invalid }
end
describe "devolver el valor de autenticación" do
 before { @user.save }
 let(:found_user) { User.find_by(email: @user.email)}
 describe "con password válido" do
 	it { should eq found_user.authenticate(@user.password)}
 end
 describe "con password inválido" do
 	let(:user_for_invalid_password) {found_user.authenticate("invalid")}
 	it { should_not eq user_for_invalid_password}
 	specify { expect(user_for_invalid_password).to be_false }
 end
end





end