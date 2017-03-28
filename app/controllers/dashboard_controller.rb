require 'dropbox_api'

class DashboardController < ApplicationController
  def index
    @emergencies = Emergency.all
    @contacts = Contact.all
    @new_contact = Contact.new
    img_urls = get_img_urls
    @img_time = img_urls[:time].strftime("Taken on %B %e '%y at %l:%M %p")
    @picam_link = img_urls[:picam]
    @usb_link = img_urls[:usb]
  end
end
