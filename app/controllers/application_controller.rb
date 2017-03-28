require 'dropbox_api'
require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def get_img_urls
    dropbox = DropboxApi::Client.new
    picam_folder = dropbox.list_folder("/TDCMakerspace/picam/").entries[-1]
    picam_results = dropbox.list_folder(picam_folder.path_display)
    picam_img = picam_results.entries[-1]
    usbcam_folder = dropbox.list_folder("/TDCMakerspace/usbcam/").entries[-1]
    usbcam_results = dropbox.list_folder(usbcam_folder.path_display)
    usbcam_img = usbcam_results.entries[-1]
    img_time = DateTime.strptime(usbcam_img.name[0..15], '%Y-%m-%d_%H-%M')
    @picam_link = dropbox.get_temporary_link(picam_img.path_display).link
    @usbcam_link = dropbox.get_temporary_link(usbcam_img.path_display).link
    return {:picam => @picam_link, :usb => @usbcam_link, :time => img_time}
  end
end
