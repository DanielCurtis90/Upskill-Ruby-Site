class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params) #[error1, error2, ..] from contact_params
    if @contact.save
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