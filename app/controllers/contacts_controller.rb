class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params) #[error1, error2, ..] from contact_params
    if @contact.save
      #This lifts the information entered on the form before it's sent to the database
      #The information is grabbed from the Parameters hash that is sent when submit is pressed
      # :contact refers to one of the keys in the Parameters hash, :name etc refers to the next key pointing to our form data
      name = params[:contact][:name] 
      email = params[:contact][:email] 
      body = params[:contact][:comments] 
      ContactMailer.contact_email(name, email, body).deliver #This uses the delivermethod from the ActiveMailer that ContactMailer inherhits from
      flash[:success] = "Message sent." #The keys for the flashes match the bootstrap format to save time
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ") #joins each error message in the error array
      redirect_to new_contact_path
    end
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end